import re
import time
import random
import unicodedata
from playwright.sync_api import sync_playwright
from playwright_stealth import Stealth

GROUP_NAME = "Siuuuu"  # Update this to your target group chat

# These are deliberately conservative. A reel must contain an exact,
# football-specific term or a known football entity before it can be sent.
FOOTBALL_TERMS = (
    "football",
    "footballer",
    "footballers",
    "soccer",
    "futbol",
    "fútbol",
    "futebol",
    "fifa",
    "uefa",
    "premier league",
    "champions league",
    "europa league",
    "conference league",
    "la liga",
    "serie a",
    "bundesliga",
    "ligue 1",
    "copa america",
    "copa libertadores",
    "ballon d or",
    "golden boot",
    "penalty kick",
    "free kick",
    "corner kick",
    "goalkeeper",
    "goalkeeping",
    "offside",
    "red card",
    "yellow card",
    "starting xi",
    "matchday",
    "transfer window",
    "football club",
    "soccer club",
    "qatar 2022",
    "campeon del mundo",
    "champion of the world",
)

FOOTBALL_ENTITIES = (
    "messi",
    "lionel messi",
    "ronaldo",
    "cristiano ronaldo",
    "cr7",
    "mbappe",
    "kylian mbappe",
    "haaland",
    "erling haaland",
    "lamine yamal",
    "diego maradona",
    "barca",
    "fc barcelona",
    "barcelona",
    "real madrid",
    "inter miami",
    "al nassr",
    "manchester united",
    "manchester city",
    "liverpool",
    "arsenal fc",
    "chelsea fc",
    "bayern munich",
    "paris saint germain",
    "wout weghorst",
    "ankara messi",
    "siuuu",
    "penaldo",
    "pendu",
    "factos",
)


def _normalise_caption(caption):
    normalised = unicodedata.normalize("NFKC", caption).casefold()
    return " ".join(re.findall(r"\w+", normalised, flags=re.UNICODE))


def _term_pattern(term):
    normalised_term = _normalise_caption(term)
    return re.compile(rf"(?<!\w){re.escape(normalised_term)}(?!\w)")


FOOTBALL_PATTERNS = tuple(
    _term_pattern(term) for term in (*FOOTBALL_TERMS, *FOOTBALL_ENTITIES)
)


def is_related(caption):
    if not caption:
        return False

    if "⚽" in unicodedata.normalize("NFKC", caption):
        return True

    normalised_caption = _normalise_caption(caption)
    return any(pattern.search(normalised_caption) for pattern in FOOTBALL_PATTERNS)


def run_session():
    """Runs a single browsing session. Returns the nap duration if taking a break."""
    with sync_playwright() as p:
        # 1. Launch Browser (using a local folder to save login state)
        print("Launching browser...")
        browser = p.chromium.launch_persistent_context(
            user_data_dir="./ig_profile",  # Saves your cookies here so you only log in once
            headless=False,  # IG requires the browser to be visible
            args=["--disable-blink-features=AutomationControlled"],
        )
        page = browser.new_page()
        Stealth().apply_stealth_sync(page)

        # 2. Go to Instagram
        page.goto("https://www.instagram.com/")
        print("Waiting 10 seconds for you to log in (if this is your first run)...")
        time.sleep(10)  # Time for you to enter username/password manually

        # 3. Go to Reels
        print("Navigating to Reels feed...")
        page.goto("https://www.instagram.com/reels/")
        time.sleep(15)

        # 3.5 Check for "Daily Limit" or other modal popups
        try:
            if page.get_by_text("You've reached your daily limit").is_visible():
                print("Detected 'Daily Limit' overlay. Closing...")
                # 1. Try a case-insensitive locator for the Close button (could be svg, button, div)
                close_btn = page.locator('[aria-label="Close" i]').first
                if close_btn.is_visible():
                    close_btn.click()

                # 2. Bulletproof fallback: Press the 'Escape' key.
                # IG modals are built for accessibility and almost always close on ESC.
                page.keyboard.press("Escape")
                time.sleep(3)  # Wait for fade-out animation

                # 3. Final Verification check
                if page.get_by_text("You've reached your daily limit").is_visible():
                    print(
                        "WARNING: Failed to close the Daily Limit overlay! Attempting page reload..."
                    )
                    page.reload()
                    time.sleep(10)
                else:
                    print("Successfully closed the overlay.")
        except Exception as e:
            print("Error checking for Daily Limit overlay:", e)

        # 4. Auto-Scroll Loop
        while True:
            try:
                # Find the active Share button in the viewport
                share_btns = page.locator('svg[aria-label="Share"]').all()
                active_btn = None
                for btn in share_btns:
                    box = btn.bounding_box()
                    if box and 0 <= box["y"] <= 900:
                        active_btn = btn
                        break

                if active_btn:
                    # Stop at the smallest visible container that owns exactly
                    # one share button. The old 15-level walk included nearby
                    # reels, so a football caption could approve an unrelated reel.
                    full_caption = active_btn.evaluate("""node => {
                        const shareSelector = 'svg[aria-label="Share"]';
                        let parent = node;
                        for (let i = 0; i < 8 && parent; i++, parent = parent.parentElement) {
                            const text = (parent.innerText || "").trim();
                            const shareCount = parent.querySelectorAll(shareSelector).length;
                            if (shareCount === 1 && text.length >= 20) {
                                const captionCandidates = [...parent.querySelectorAll('[dir="auto"]')]
                                    .map(element => (element.innerText || "").trim())
                                    .filter(value => value && value !== "Follow" && !/^[0-9,.]+[KMB]?$/i.test(value));
                                return captionCandidates.length
                                    ? captionCandidates[captionCandidates.length - 1]
                                    : text;
                            }
                        }
                        return "";
                    }""")

                    print(f"Caption found: {repr(full_caption[:60])}...")

                    # Send only when the scoped reel text has a football signal.
                    if is_related(full_caption):
                        print(">>> MATCH FOUND! Attempting to share...")

                        active_btn.click()
                        time.sleep(2)

                        # Type group name in the search box (IG's search input uses name='queryBox')
                        search_box = page.locator("input[name='queryBox']")
                        search_box.fill(GROUP_NAME)
                        time.sleep(3)  # Wait for IG to load search results

                        # Click the group/user in the list
                        page.get_by_text(GROUP_NAME).first.click()
                        time.sleep(1)

                        # Click Send (sometimes it's a div acting as a button with exact text)
                        page.get_by_text("Send", exact=True).first.click()
                        print(f">>> Successfully sent to {GROUP_NAME}!")
                        time.sleep(1)  # Wait for modal to close
                else:
                    print("No active Share button found in viewport.")

                print("Scrolling to next reel...")
                page.keyboard.press("ArrowDown")

                # Sleep for a random amount of time (CRITICAL to avoid bans)
                prob = random.random()
                if prob < 0.06:
                    # 15% chance to "watch a full reel" or get distracted
                    sleep_time = random.uniform(10.0, 20.0)
                    print(
                        f"Taking a longer pause to watch this reel ({sleep_time:.1f}s)..."
                    )
                    time.sleep(sleep_time)
                elif prob < 2:
                    # Normal scrolling behavior
                    sleep_time = random.uniform(0.3, 4.7)
                    time.sleep(sleep_time)
                else:
                    # 3% chance to close the app and take a long break
                    # Sleep between 20 and 30 minutes
                    nap_time = random.uniform(6 * 60, 30 * 60)
                    print(f"\n--- GOING TO SLEEP ---")
                    print(
                        f"Closing the browser and taking a break for {nap_time/60:.1f} minutes to look human."
                    )
                    # Returning from this function cleanly exits the Playwright context, closing the browser.
                    return nap_time

            except Exception as e:
                print(f"Error on this reel (skipping): {e}")
                page.keyboard.press("ArrowDown")
                time.sleep(random.uniform(4.0, 8.0))


def run_bot():
    """Main loop that keeps the bot alive across multiple browsing sessions."""
    while True:
        try:
            # run_session will block and run the bot, returning only when it decides to take a long break
            nap_time = run_session()

            # If the session returned a nap time, sleep while the browser is closed
            if nap_time:
                time.sleep(nap_time)

        except Exception as e:
            print(f"Critical session error: {e}. Restarting browser in 60 seconds...")
            time.sleep(60)


if __name__ == "__main__":
    run_bot()
