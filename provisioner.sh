echo "PROVISIONER: Starting"
cd ~

echo "PROVISIONER: Installing Seashell"
curl https://gist.githubusercontent.com/jerzygangi/4a5f5fc48f8c3996bd8dc539b57c6e02/raw/7d6a9d2f2edc75af48fae2cc9dcd9891c7338b93/install.sh | bash -

echo "PROVISIONER: Whip the machine into shape"
./seashell/commands/baseline
./seashell/commands/allow_opt_to_be_writable_by_root_group
./seashell/commands/add_centos_user_to_root_group

echo "PROVISIONER: Installing PostgreSQL Client + Server"
./seashell/commands/install_postgres_server
./seashell/commands/install_postgres_client
./seashell/commands/point_bundler_to_postgres

echo "PROVISIONER: Adding PostgreSQL database user for the URL Shortener Rails application"
cat << EOF | sudo -u postgres -i bash -c "psql"
CREATE USER rails_application WITH PASSWORD 'insecure' CREATEDB SUPERUSER;
EOF

echo "PROVISIONER: Allowing PostgreSQL MD5 username+password authentication"
cat << EOF | sudo tee /var/lib/pgsql/9.5/data/pg_hba.conf
# PostgreSQL Client Authentication Configuration File
#
# Trust all connections, because ident is not sane for local development
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
EOF
sudo systemctl restart postgresql-9.5.service

echo "PROVISIONER: Installing Ruby"
./seashell/commands/install_ruby

echo "PROVISIONER: Installing Git"
./seashell/commands/install_git

echo "PROVISIONER: Installing all gems"
source /home/`whoami`/.bash_profile
cd /home/`whoami`/urlshortener
bundle

echo "PROVISIONER: Complete"
