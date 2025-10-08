# GitHub Actions CI/CD Setup

This document explains how to configure the CI/CD pipeline for deploying to Fly.io.

## Prerequisites

- A Fly.io account with access to the app `polished-snowflake-9723`
- Admin access to the GitHub repository
- Fly CLI installed and authenticated

## Setup Instructions

### 1. Generate Fly.io Deploy Token

Run the following command to create a deploy token:

```bash
flyctl tokens create deploy -a polished-snowflake-9723 -n "GitHub Actions Deploy Token"
```

Copy the token that is displayed (it starts with `FlyV1 fm2_...`).

⚠️ **Important**: Keep this token secure and never commit it to the repository!

### 2. Add Token to GitHub Secrets

1. Go to your GitHub repository: https://github.com/abaetefest/abaete_fest_api
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add the following secret:
   - **Name**: `FLY_API_TOKEN`
   - **Value**: Paste the token you generated in step 1

### 3. Workflow Configuration

The workflow is configured in `.github/workflows/deploy.yml` and will:
- Trigger on every push to the `main` branch
- Deploy to Fly.io app `polished-snowflake-9723`
- Use the `--remote-only` flag to build on Fly.io servers

### 4. Testing the Deployment

Once the secret is added:
1. Push changes to the `main` branch
2. Go to the **Actions** tab in your GitHub repository
3. Monitor the deployment workflow
4. Check the deployment status on Fly.io: `fly status -a polished-snowflake-9723`

## Security Notes

- The deploy token is scoped to only manage the specific app
- Tokens expire after 20 years by default (you can set a shorter expiry with `-x` flag)
- Never commit tokens to the repository
- If a token is compromised, revoke it immediately and generate a new one

## Revoking Tokens

To list all tokens:
```bash
flyctl tokens list
```

To revoke a compromised token:
```bash
flyctl tokens revoke <TOKEN_ID>
```

## Troubleshooting

- **Deployment fails**: Check the Actions logs in GitHub
- **Authentication issues**: Verify the `FLY_API_TOKEN` secret is correctly set
- **Build errors**: Review the build logs in the Actions output

## Additional Commands

```bash
# Check deployment status
fly status -a polished-snowflake-9723

# View logs
fly logs -a polished-snowflake-9723

# SSH into the app
fly ssh console -a polished-snowflake-9723
```
