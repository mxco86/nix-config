let
  # SSH host key for sanchez
  sanchez = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAxByksxshcoCjlr1GYQU3YCeK6/egD7pPxKs+pf3CjI";
  # SSH host key for rossi
  rossi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICqt/3BgBjhFhlTLKvt5qSi94tW5Fb5PC8VDTqIE6HGc";
in {
  "secrets/rossi/homepage-dashboard-env.age".publicKeys = [rossi sanchez];
  "secrets/rossi/kavita.age".publicKeys = [rossi];
}
