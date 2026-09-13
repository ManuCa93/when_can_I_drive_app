import asyncio
from playwright.async_api import async_playwright
import os
import time

async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page(
            viewport={'width': 414, 'height': 896} # mobile size roughly
        )
        
        # Wait a bit for server to be fully ready
        await asyncio.sleep(2)
        
        print("Navigating to localhost:8080...")
        try:
            await page.goto("http://localhost:8080", timeout=60000)
        except Exception as e:
            print("Failed to navigate:", e)
            await browser.close()
            return
            
        print("Page loaded, waiting for Flutter app to initialize...")
        await asyncio.sleep(10) # Wait for flutter app rendering
        
        if not os.path.exists('screenshots'):
            os.makedirs('screenshots')
            
        print("Taking Dashboard screenshot...")
        await page.screenshot(path='screenshots/dashboard.png')
        
        # Try to click Settings or History, since we saw History and Settings in commits
        # Flutter web uses canvas usually, so we might have to click by coordinates
        # Or if it's HTML renderer, we might be able to click elements.
        # It's safer to just take the main dashboard screenshot if it's canvas.
        # But maybe we can take a full page screenshot.
        
        # We can also just take the dashboard since that's a new feature anyway (DisclaimerWidget, BAC header)
        print("Screenshots taken.")
        await browser.close()

asyncio.run(main())
