﻿namespace MalusAdmin.Common;

public class TokenData
{
    public int UserId { get; set; }

    public string UserName { get; set; }

    public string UserAccount { get; set; }

    public bool IsSuperAdmin { get; set; }

    public List<int> UserRolesId { get; set; }

    public List<string> UserPermiss { get; set; }

    public DateTime? LoginTime { get; set; }

    public DateTime? ExpireTime { get; set; }
}