import { computed, ref, shallowRef } from 'vue';
import type { RouteRecordRaw } from 'vue-router';
import { defineStore } from 'pinia';
import { useBoolean } from '@sa/hooks';
import type { CustomRoute, ElegantConstRoute, LastLevelRouteKey, RouteKey, RouteMap } from '@elegant-router/types';
import { SetupStoreId } from '@/enum';
import { router } from '@/router';
import { createStaticRoutes, getAuthVueRoutes } from '@/router/routes';
import { ROOT_ROUTE } from '@/router/routes/builtin';
import { getRouteName, getRoutePath } from '@/router/elegant/transform';
import { fetchGetConstantRoutes, fetchIsRouteExist, getUserRoutes } from '@/service/api';
import { useAppStore } from '../app';
import { useAuthStore } from '../auth';
import { useTabStore } from '../tab';
import {
  filterAuthRoutesByRoles,
  getBreadcrumbsByRoute,
  getCacheRouteNames,
  getGlobalMenusByAuthRoutes,
  getSelectedMenuKeyPathByKey,
  isRouteExistByRouteName,
  sortRoutesByOrder,
  transformMenuToSearchMenus,
  updateLocaleOfGlobalMenus
} from './shared';

export const useRouteStore = defineStore(SetupStoreId.Route, () => {
  const appStore = useAppStore();
  const authStore = useAuthStore();
  const tabStore = useTabStore();
  const { bool: isInitConstantRoute, setBool: setIsInitConstantRoute } = useBoolean();
  const { bool: isInitAuthRoute, setBool: setIsInitAuthRoute } = useBoolean();

  /**
   * Auth route mode
   *
   * It recommends to use static mode in the development environment, and use dynamic mode in the production
   * environment, if use static mode in development environment, the auth routes will be auto generated by plugin
   * "@elegant-router/vue"
   */
  const authRouteMode = ref(import.meta.env.VITE_AUTH_ROUTE_MODE);

  /** Home route key */
  const routeHome = ref(import.meta.env.VITE_ROUTE_HOME);

  /**
   * Set route home
   *
   * @param routeKey Route key
   */
  function setRouteHome(routeKey: LastLevelRouteKey) {
    routeHome.value = routeKey;
  }

  /** auth routes */
  const authRoutes = shallowRef<ElegantConstRoute[]>([]);

  /**
   * 向路由列表中添加认证路由。
   *
   * @param routes {ElegantConstRoute[]} 待添加认证信息的路由数组。
   *
   *   此函数首先将已存在的认证路由映射到一个 Map 中，然后将待添加的路由也添加到这个 Map 中， 最后将 Map 中的值转换回数组，更新认证路由列表。
   */
  function addAuthRoutes(routes: ElegantConstRoute[]) {
    // console.log('authRoutes.value', authRoutes.value);
    // 创建一个映射，用于存储认证路由的名称和路由对象
    const authRoutesMap = new Map();

    // 遍历传入的路由数组，并将其添加到认证路由映射中
    routes.forEach(route => {
      authRoutesMap.set(route.name, route);
    });

    // 更新认证路由列表，用映射中的值替换原有数组
    authRoutes.value = Array.from(authRoutesMap.values());

    console.log('更新认证路由列表', authRoutes.value);
  }

  const removeRouteFns: (() => void)[] = [];

  /** Global menus */
  const menus = ref<App.Global.Menu[]>([]);
  const searchMenus = computed(() => transformMenuToSearchMenus(menus.value));

  /** 获取全局菜单 */
  function getGlobalMenus(routes: ElegantConstRoute[]) {
    menus.value = getGlobalMenusByAuthRoutes(routes);
  }

  /** Update global menus by locale */
  function updateGlobalMenusByLocale() {
    menus.value = updateLocaleOfGlobalMenus(menus.value);
  }

  /** Cache routes */
  const cacheRoutes = ref<RouteKey[]>([]);

  /**
   * Get cache routes
   *
   * @param routes Vue routes
   */
  function getCacheRoutes(routes: RouteRecordRaw[]) {
    cacheRoutes.value = getCacheRouteNames(routes);
  }

  /**
   * Add cache routes
   *
   * @param routeKey
   */
  function addCacheRoutes(routeKey: RouteKey) {
    if (cacheRoutes.value.includes(routeKey)) return;

    cacheRoutes.value.push(routeKey);
  }

  /**
   * Remove cache routes
   *
   * @param routeKey
   */
  function removeCacheRoutes(routeKey: RouteKey) {
    const index = cacheRoutes.value.findIndex(item => item === routeKey);

    if (index === -1) return;

    cacheRoutes.value.splice(index, 1);
  }

  /**
   * Re cache routes by route key
   *
   * @param routeKey
   */
  async function reCacheRoutesByKey(routeKey: RouteKey) {
    removeCacheRoutes(routeKey);

    await appStore.reloadPage();

    addCacheRoutes(routeKey);
  }

  /**
   * Re cache routes by route keys
   *
   * @param routeKeys
   */
  async function reCacheRoutesByKeys(routeKeys: RouteKey[]) {
    for await (const key of routeKeys) {
      await reCacheRoutesByKey(key);
    }
  }

  /** Global breadcrumbs */
  const breadcrumbs = computed(() => getBreadcrumbsByRoute(router.currentRoute.value, menus.value));

  /** Reset store */
  async function resetStore() {
    const routeStore = useRouteStore();

    routeStore.$reset();

    resetVueRoutes();

    // 重置存储后，需要重新初始化常量路由
    await initConstantRoute();
  }

  /** 重置vue路由 */
  function resetVueRoutes() {
    console.log('重置vue路由');
    removeRouteFns.forEach(fn => fn());
    removeRouteFns.length = 0;
  }

  /** 常量路由 */
  const constantRoutes = shallowRef<ElegantConstRoute[]>([]);

  function addConstantRoutes(routes: ElegantConstRoute[]) {
    const constantRoutesMap = new Map<string, ElegantConstRoute>([]);

    routes.forEach(route => {
      constantRoutesMap.set(route.name, route);
    });

    constantRoutes.value = Array.from(constantRoutesMap.values());
  }

  /** 初始化常量路由 */
  async function initConstantRoute() {
    if (isInitConstantRoute.value) return;
    const staticRoute = createStaticRoutes();
    console.log('1.初始化常量路由', staticRoute.constantRoutes);
    addConstantRoutes(staticRoute.constantRoutes);
    handleConstantAndAuthRoutes();
    setIsInitConstantRoute(true);
    // initAuthRoute();
    // 先获取静态路由
    // const { constantRoutes } = createStaticRoutes();
    // addAuthRoutes(constantRoutes);
    // console.log('先获取静态路由', constantRoutes);
  }

  /** 初始化身份验证路由 */
  async function initAuthRoute() {
    // if (authRouteMode.value === 'static') {
    //   await initStaticAuthRoute();
    // } else {
    //   await initDynamicAuthRoute();
    // }
    await initDynamicAuthRoute();
    tabStore.initHomeTab();
  }

  /** 初始化静态身份验证路由 */
  // async function initStaticAuthRoute() {
  //   const { authRoutes: staticAuthRoutes } = createStaticRoutes();

  //   if (authStore.isStaticSuper) {
  //     addAuthRoutes(staticAuthRoutes);
  //   } else {
  //     const filteredAuthRoutes = (staticAuthRoutes, authStore.userInfo.roles);

  //     addAuthRoutes(filteredAuthRoutes);
  //   }

  //   handleConstantAndAuthRoutes();

  //   setIsInitAuthRoute(true);
  // }

  /** 初始化动态身份验证路由 */
  async function initDynamicAuthRoute() {
    const data = await getUserRoutes();
    console.log('2. 获取动态身份验证路由', data.data?.routes);
    addAuthRoutes(data.data?.routes ?? []);

    handleConstantAndAuthRoutes();
    const home = data.data?.home || 'home';
    console.log('3. 设置主页', home);
    setRouteHome(home);

    handleUpdateRootRouteRedirect(home);

    setIsInitAuthRoute(true);
  }

  /** 处理常量和身份验证路由 */
  function handleConstantAndAuthRoutes() {
    const allRoutes = [...constantRoutes.value, ...authRoutes.value];

    const sortRoutes = sortRoutesByOrder(allRoutes);

    const vueRoutes = getAuthVueRoutes(sortRoutes);

    resetVueRoutes();
    console.log('该用户的路由信息+将路由添加到vue路由器', vueRoutes);
    addRoutesToVueRouter(vueRoutes);

    getGlobalMenus(sortRoutes);

    getCacheRoutes(vueRoutes);
  }

  /**
   * 将路由添加到vue路由器
   *
   * @param routes Vue routes
   */
  function addRoutesToVueRouter(routes: RouteRecordRaw[]) {
    routes.forEach(route => {
      const removeFn = router.addRoute(route);
      addRemoveRouteFn(removeFn);
    });
  }

  /**
   * 添加-删除路由
   *
   * @param fn
   */
  function addRemoveRouteFn(fn: () => void) {
    removeRouteFns.push(fn);
  }

  /**
   * 当身份验证路由模式为动态时更新根路由重定向
   *
   * @param redirectKey Redirect route key
   */
  function handleUpdateRootRouteRedirect(redirectKey: LastLevelRouteKey) {
    const redirect = getRoutePath(redirectKey);

    if (redirect) {
      const rootRoute: CustomRoute = { ...ROOT_ROUTE, redirect };

      router.removeRoute(rootRoute.name);

      const [rootVueRoute] = getAuthVueRoutes([rootRoute]);

      router.addRoute(rootVueRoute);
    }
  }

  /**
   * Get is auth route exist
   *
   * @param routePath Route path
   */
  async function getIsAuthRouteExist(routePath: RouteMap[RouteKey]) {
    const routeName = getRouteName(routePath);

    if (!routeName) {
      return false;
    }

    if (authRouteMode.value === 'static') {
      const { authRoutes: staticAuthRoutes } = createStaticRoutes();
      return isRouteExistByRouteName(routeName, staticAuthRoutes);
    }

    const { data } = await fetchIsRouteExist(routeName);

    return data;
  }

  /**
   * Get selected menu key path
   *
   * @param selectedKey Selected menu key
   */
  function getSelectedMenuKeyPath(selectedKey: string) {
    return getSelectedMenuKeyPathByKey(selectedKey, menus.value);
  }

  /**
   * Get selected menu meta by key
   *
   * @param selectedKey Selected menu key
   */
  function getSelectedMenuMetaByKey(selectedKey: string) {
    // The routes in router.options.routes are static, you need to use router.getRoutes() to get all the routes.
    const allRoutes = router.getRoutes();

    return allRoutes.find(route => route.name === selectedKey)?.meta || null;
  }

  return {
    resetStore,
    routeHome,
    menus,
    searchMenus,
    updateGlobalMenusByLocale,
    cacheRoutes,
    reCacheRoutesByKey,
    reCacheRoutesByKeys,
    breadcrumbs,
    initConstantRoute,
    isInitConstantRoute,
    initAuthRoute,
    isInitAuthRoute, // 是不是初始化过权限路由
    setIsInitAuthRoute,
    getIsAuthRouteExist,
    getSelectedMenuKeyPath,
    getSelectedMenuMetaByKey
  };
});
