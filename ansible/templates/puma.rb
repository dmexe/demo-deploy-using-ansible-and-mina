#!/usr/bin/env puma

require 'pathname'

_num_workers = {{ ansible_processor_cores }}
_working_dir = Pathname.new('{{ deploy_to }}/current')
_rails_env   = '{{ rails_env }}'

workers _num_workers
directory _working_dir.to_s
rackup _working_dir.join("config.ru").to_s
environment _rails_env

daemonize false

pidfile _working_dir.join("tmp/pids/puma.pid").to_s
state_path _working_dir.join("tmp/pids/puma.state").to_s
threads 0,16
bind "tcp://127.0.0.1:3000"

on_restart do
  puts 'On restart...'
end

on_worker_boot do
  puts 'On worker boot...'
end

