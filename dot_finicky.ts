// ~/.finicky.ts
// Note finky is not actively maitained anymore.
import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

export default {
  defaultBrowser: "Safari",
  options: {
    checkForUpdates: true
  },
  handlers: [
    {
      match: ["*localhost:*/"],
      browser: "Firefox"
    },
    {
      match: ["*.jungleboogie.pl/*"],
      browser: "Google Chrome:jungleboogie.pl"
    }, 
    {
      match: ["*.gov/*"],
      browser: "Google Chrome:priv"
    },
    {
      match: [
        "*Library/Jupyter/runtime/*",
        "*notebooks.jarvislabs.ai*",
     ],
      browser: "Vivaldi:Default"
    },
  ]
} satisfies FinickyConfig;