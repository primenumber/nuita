server 'nuita.net', user: 'kyp', roles: %w{app db web}, port: 22

#デプロイするサーバーにsshログインする鍵の情報。サーバー編で作成した鍵のパス
set :ssh_options, keys: '~/.ssh/id_rsa'
