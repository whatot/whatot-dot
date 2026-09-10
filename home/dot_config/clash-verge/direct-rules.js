// Clash Verge Rev global extension script for macOS and Arch-family Linux.
// Keep direct-routing rules in this list so they can be reviewed and extended
// without editing a generated subscription profile.
var directRules = [
  "DOMAIN-SUFFIX,amazonaws.cn,DIRECT",
  "DOMAIN-SUFFIX,amazonaws.com.cn,DIRECT",
  "DOMAIN-SUFFIX,cn,DIRECT",
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
