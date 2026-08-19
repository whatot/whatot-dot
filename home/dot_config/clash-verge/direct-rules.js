// macOS-only Clash Verge Rev global extension script.
// Keep direct-routing rules in this list so they can be reviewed and extended
// without editing the generated subscription profile.
var directRules = [
  // Exact host only. Add DOMAIN-SUFFIX when all subdomains should be direct.
  "DOMAIN,sbtunnel.xiaoaojianghu.fun,DIRECT"
];

function main(config) {
  var oldRules = Array.isArray(config["rules"]) ? config["rules"] : [];
  var prependRules = [];

  // Avoid duplicate entries if another extension already supplied the rule.
  for (var i = 0; i < directRules.length; i++) {
    if (oldRules.indexOf(directRules[i]) === -1) {
      prependRules.push(directRules[i]);
    }
  }

  // Prepend so these rules win over subscription proxy/rule-set matches.
  config["rules"] = prependRules.concat(oldRules);
  return config;
}
