// ~/.finicky.ts
// Note finicky is not actively maintained anymore.
import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

export default {
  defaultBrowser: "Safari",
  options: {
    checkForUpdates: true
  },
  handlers: [
    // SolveIt local dev → Chrome priv
    {
      match: ["*localhost:5001/*", "*localhost:5001*"],
      browser: "Google Chrome:priv"
    },

    // Local development → Firefox
    {
      match: ["*localhost:*/"],
      browser: "Firefox"
    },

    // JungleBoogie work → Chrome profile
    {
      match: ["*.jungleboogie.pl/*"],
      browser: "Google Chrome:jungleboogie.pl"
    },

    // Government sites → Chrome priv profile
    {
      match: ["*.gov.pl/*",
	"*.orb.local/*",
      ],
      browser: "Google Chrome:priv"
    },

    // Jupyter notebooks → Vivaldi
    {
      match: [
        "*Library/Jupyter/runtime/*",
        "*notebooks.jarvislabs.ai*",
      ],
      browser: "Vivaldi:Default"
    },

    // SolveIt → Chrome priv
    {
      match: [
        "*solve.it.com*",
        "*si.answer.ai*",
      ],
      browser: "Google Chrome:priv"
    },

    // Arc
    {
      match: [
        "*thinkingmachines.ai*",
        "*speakleash.org.pl*",
        "*bielik.ai*",
      ],
      browser: "Arc"
    },

    // Work/Dev tools → Comet
    {
      match: [
        "*github.com*",
        "*gist.github.com*",
        "*githubusercontent.com*",
        "*arxiv.org*",
        "*huggingface.co*",
        "*openrouter.ai*",
        "*openrouter.com*",
        "*grep.app*",
        "*ampcode.com*",
        "*mermaid.live*",
        "*console.verda.com*",
        "*datadoghq.com*",
        "*simonwillison.net*",
        "*platform.claude.com*",
        "*docs.claude.com*",
        "*claude.ai*",
        "*platform.openai.com*",
        "*auth.openai.com*",
        "*openai.com*",
        "*aistudio.google.com*",
        "*console.groq.com*",
        "*chatgpt.com*",
        "*cloudflare.com*",
        "*fast.ai*",
        "*fastcore.fast.ai*",
        "*fastht.ml*",
        "*answer.ai*",
        "*zed.dev*",
        "*pypi.org*",
        "*crates.io*",
        "*docs.rs*",
        "*modelcontextprotocol.io*",
        "*hetzner.com*",
        "*tailscale.com*",
        "*app.reviewnb.com*",
        "*app.gusto.com*",
        "*login.gusto.com*",
        "*docs.pyinfra.com*",
        "*docs.litellm.ai*",
        "*docs.vllm.ai*",
        "*docs.astral.sh*",
        "*docs.python.org*",
        "*docs.github.com*",
        "*context7.com*",
        "*anthropic.com*",
        "*web.archive.org*",
        "*posthog.com*",
        "*artificalanalysis.ai*",
        "*jina.ai*",
        "*kardas.org*",
        // Jupyter servers on remote IPs
        "*:8888*",
      ],
      browser: "Comet"
    },

    // Private/Personal stays with Safari (default):
    // perplexity, disney, netflix, youtube, facebook, linkedin,
    // amazon, paypal, wise, taxly, bambiboo, dyson, edukacja-dzieci,
    // datasport, netflix, wikipedia, zotero, google mail/drive, etc.
  ]
} satisfies FinickyConfig;
