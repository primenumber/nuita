server '118.27.27.153', user: 'kyp', roles: %w{app db web}, port: 22

#デプロイするサーバーにsshログインする鍵の情報。サーバー編で作成した鍵のパス
set :ssh_options, keys: '~/.ssh/neo_id_rsa'
