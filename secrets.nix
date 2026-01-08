let
  # SSH host key for sanchez
  sanchez = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAxByksxshcoCjlr1GYQU3YCeK6/egD7pPxKs+pf3CjI";
in
{
  "hosts/nixos/sanchez/secrets.age".publicKeys = [ sanchez ];
}