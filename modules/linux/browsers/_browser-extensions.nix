{ inputs, pkgs }:
{
  # https://nur.nix-community.org/repos/rycee/
  extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
    # Essentials
    adnauseam
    bitwarden
    darkreader
    clearurls
    decentraleyes
    
    # QoL
    consent-o-matic
    don-t-fuck-with-paste
    auto-sort-bookmarks
    tree-style-tab

    # Media
    unpaywall
    h264ify
    youtube-shorts-block
    youtube-high-definition
  ];
}