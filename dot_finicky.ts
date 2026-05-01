import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

const isGmailSearchLink = (url: URL) =>
  url.hostname === "mail.google.com" &&
  url.pathname.startsWith("/mail/") &&
  url.hash.startsWith("#search/");

const isGoogleAccountLink = (url: URL) =>
  url.hostname === "accounts.google.com";

export default {
  defaultBrowser: "Safari",
  options: {
    checkForUpdates: true
  },
  rewrite: [
    {
      match: isGmailSearchLink,
      url: (url) => {
        url.searchParams.set("authuser", "piotr@tryvirgil.com");
        return url;
      }
    }
  ],
  handlers: [
    {
      match: isGmailSearchLink,
      browser: "Google Chrome:aai"
    },
    {
      match: isGoogleAccountLink,
      browser: "Google Chrome:aai"
    },
    {
      match: ["*localhost*", "*127.0.0.1*"],
      browser: "Google Chrome:aai"
    },
    {
      match: [
        "*solve.it.com*",
        "*solveit.pub*",
        "*si.answer.ai*",
      ],
      browser: "Google Chrome:aai"
    },
  ]
} satisfies FinickyConfig;
