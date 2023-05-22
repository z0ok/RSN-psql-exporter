if id 'psql_exporter' &>/dev/null; then
    echo '[+] User found'
else
    echo '[-] Creating user'
    useradd -rs /bin/false psql_exporter
fi
cp ./psql_exporter.service /etc/systemd/system/
systemctl daemon-reload
sleep 1
systemctl enable psql_exporter
sleep 1
systemctl restart psql_exporter
sleep 1
systemctl status psql_exporter
