// ~/.finicky.js
// Note finky is not actively maitained anymore.
module.exports = {
  defaultBrowser: "Safari",
  options: {
    // Hide the finicky icon from the top bar. Default: false
    hideIcon: true, 
  },
  handlers: [
    {
      // Open apple.com and example.org urls in Safari
      match: ["apple.com/*", "example.org/*"],
      browser: "Safari"
    },

    {
      match: [/localhost:.*/],
      browser: "Arc"
    },
    
    {
      match: [
        /Library\/Jupyter\/runtime/,
        /notebooks.\.jarvislabs.ai/,
     ],
      browser: { 
        name: "Vivaldi",
        profile: "Default", 
      }
    },
  ]
};
