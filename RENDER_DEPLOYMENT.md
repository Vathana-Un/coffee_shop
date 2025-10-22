# Deploy Coffee Shop Telegram Bot to Render

This guide will help you deploy your Spring Boot application to Render.

## Prerequisites

1. A Render account (sign up at https://render.com)
2. Your code pushed to a Git repository (GitHub, GitLab, or Bitbucket)
3. Railway MySQL database (or any accessible MySQL database)

## Files Created for Deployment

- `render.yaml` - Render service configuration
- `build.sh` - Build script for Render
- `build.gradle` - Already configured with `bootJar` task

## Step-by-Step Deployment

### 1. Push Your Code to Git

```bash
git add .
git commit -m "Add Render deployment configuration"
git push origin main
```

### 2. Create a New Web Service on Render

1. Go to https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Connect your Git repository
4. Select your `coffee-shop-telegram-bot` repository

### 3. Configure the Web Service

Render should auto-detect the `render.yaml` file, but verify these settings:

**Basic Settings:**
- **Name:** `coffee-shop-telegram-bot`
- **Runtime:** `Docker`
- **Dockerfile Path:** `./Dockerfile`

**Advanced Settings:**
- **Auto-Deploy:** Yes (recommended)

**Note:** Render doesn't have native Java runtime. We use Docker to containerize the Spring Boot application.

### 4. Set Environment Variables

In the Render dashboard, go to **Environment** tab and add these variables:

| Key | Value | Notes |
|-----|-------|-------|
| `DB_URL` | `jdbc:mysql://mainline.proxy.rlwy.net:24944/railway?allowPublicKeyRetrieval=true&useSSL=false` | Your Railway MySQL URL |
| `DB_USERNAME` | `root` | Your database username |
| `DB_PASSWORD` | `uRgNaHYhdJicKUSQVaNDZmWeLrAHMIBX` | Your database password |
| `TELEGRAM_TOKEN` | `7660426119:AAGW_1dhVTB6krAzXWnYJ9CJ_-nJv_8q9jc` | Your Telegram bot token |
| `TELEGRAM_CHAT_ID` | `1059646074` | Your Telegram chat ID |

**Important:** Mark sensitive variables (passwords, tokens) as **Secret** in Render.

### 5. Deploy

1. Click **"Create Web Service"**
2. Render will:
   - Clone your repository
   - Run the build command (`./gradlew clean bootJar`)
   - Start your application
   - Assign a public URL (e.g., `https://coffee-shop-telegram-bot.onrender.com`)

### 6. Monitor Deployment

- Watch the **Logs** tab for build and runtime logs
- First deployment takes 5-10 minutes
- Once deployed, you'll see: `Started CoffeeShopTelegramBotApplication`

### 7. Access Your Application

Your app will be available at:
```
https://coffee-shop-telegram-bot.onrender.com
```

Test the reservation form at:
```
https://coffee-shop-telegram-bot.onrender.com/reservation
```

## Important Notes

### Free Tier Limitations

If using Render's free tier:
- Service spins down after 15 minutes of inactivity
- First request after spin-down takes 30-60 seconds (cold start)
- 750 hours/month free

### Database Connection

- Your app connects to Railway MySQL via public hostname
- Ensure Railway MySQL allows external connections
- Connection pooling is configured in `application.properties`

### Automatic Deployments

- Every push to your `main` branch triggers a new deployment
- Disable in Render dashboard if you want manual deploys

### Custom Domain (Optional)

1. Go to **Settings** → **Custom Domain**
2. Add your domain
3. Update DNS records as instructed

## Troubleshooting

### Build Fails

Check logs for:
- Java version mismatch (requires Java 17)
- Gradle build errors
- Missing dependencies

### Application Won't Start

Common issues:
- Missing environment variables
- Database connection timeout
- Port binding issues (ensure using `$PORT`)

### Database Connection Errors

- Verify Railway MySQL is running
- Check DB_URL format is correct
- Ensure Railway allows external connections
- Test connection locally first

## Useful Commands

### View Logs
```bash
# In Render dashboard → Logs tab
# Or use Render CLI:
render logs -s coffee-shop-telegram-bot
```

### Manual Deploy
```bash
# In Render dashboard → Manual Deploy button
# Or use Render CLI:
render deploy -s coffee-shop-telegram-bot
```

### Shell Access
```bash
# In Render dashboard → Shell tab
# Or use Render CLI:
render shell -s coffee-shop-telegram-bot
```

## Alternative: Deploy via Render Blueprint

If you prefer Infrastructure as Code:

1. Push `render.yaml` to your repository
2. In Render dashboard: **New +** → **Blueprint**
3. Connect repository
4. Render reads `render.yaml` and creates services automatically

## Support

- Render Docs: https://render.com/docs
- Render Community: https://community.render.com
- Spring Boot on Render: https://render.com/docs/deploy-spring-boot

## Next Steps

After deployment:
1. Test all pages (home, menu, reservation, etc.)
2. Submit a test reservation
3. Verify data saves to Railway MySQL
4. Check Telegram notification arrives
5. Set up monitoring/alerts (optional)
6. Configure custom domain (optional)
