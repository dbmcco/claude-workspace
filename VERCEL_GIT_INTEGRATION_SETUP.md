# Vercel Git Integration Setup - Critical Configuration

**ABOUTME:** Critical configuration guide for Vercel deployments from GitHub repositories
**ABOUTME:** Troubleshooting guide for automated deployment triggers and email verification requirements

## Issue Summary

Vercel deployments from GitHub were not triggering automatically despite showing a connected Git integration.

## Root Cause

**Git commit author email must match the Vercel Hobby team owner's verified email address.**

### Configuration Requirements

1. **Git Author Email Verification**
   - The git commit author email MUST match the primary email on both:
     - GitHub account (verified email)
     - Vercel account (team owner email)
   - For Hobby teams: Only the team owner's commits will trigger deployments

2. **Local Git Configuration**
   ```bash
   # Check current git config
   git config user.email

   # Update to match Vercel/GitHub email
   git config user.email "your-verified-email@domain.com"
   ```

3. **Vercel Hobby Team Limitations**
   - Commits must be authored by the Hobby team owner
   - Non-owner commits will be rejected with "commit author is required" error
   - Solution: Upgrade to Pro team OR ensure all commits use owner's email

## Troubleshooting Steps

1. **Verify Email Alignment**
   - GitHub: Settings → Emails (check primary/verified)
   - Vercel: Account Settings → General (check email)
   - Local: `git config user.email` (must match above)

2. **If Deployments Don't Trigger**
   - Check git author: `git log --format='%an <%ae>' -1`
   - Ensure email matches exactly (case-sensitive)
   - Re-authenticate GitHub integration if needed

3. **Common Issues**
   - Multiple git configs: Check `git config --list | grep user.email`
   - Wrong email in commits: Update config before pushing
   - Cached credentials: Re-auth GitHub in Vercel

## Example Fix

```bash
# Our issue: Git was using braydon@dbmcco.com
# Correct email: b@mcco.us

git config user.email "b@mcco.us"
git commit --allow-empty -m "Deploy with correct author"
git push origin main
# ✅ Deployment triggered successfully
```

## Best Practices

1. Set git config correctly before first commit
2. Use same email across GitHub, Vercel, and git config
3. For teams: Consider Pro plan to allow multiple contributors
4. Document the required email in project README

---

**Last Updated:** 2025-06-06  
**Issue Discovered During:** MoneyCommand E2E Integration Testing