class puppet {

	Package { 
		ensure	=>	'installed',
	}
	package { 'vim-enhanced': }
	package { 'curl': }
	package { 'git': }
	
	user { 'monitor':
 	 ensure           => 'present',
  	 home             => '/home/monitor',
  	 shell            => '/bin/bash',
  	 uid              => '501',
	}

	file{'/home/monitor':
		ensure	=> 'directory',
	}
	
	file{ '/home/monitor/scripts':
		ensure	=>	'directory',
	}
	
	exec{'memory_check':
		command	=>	"/usr/bin/wget -q https://raw.githubusercontent.com/seth12619/CentOS-Exercises/master/memory_check.sh -O /home/monitor/scripts/memory_check",
		creates	=>	"/home/monitor/scripts/memory_check",
	}

	file{'/home/monitor/scripts/memory_check':
		mode => 0755,
		require => Exec["memory_check"],
	}
	
	file{ '/home/monitor/src/':
		ensure	=>	'directory',
	}
	
	file{ '/home/monitor/src/my_memory_check':
		ensure	=>	'memory_check',
		target	=>	'/home/monitor/scripts/memory_check',
	}
	
	cron{ 'my_memory_check':
		command => '/home/monitor/src/my_memory_check -c 90 -w 50 -e mail@email.com',
		user    => 'monitor',
		hour    => 0,
		minute  => 10,
	}

	file{'/etc/localtime':
		ensure	=> present,
		source	=>	'/usr/share/zoneinfo/Asia/Manila',
	}
	
}



include puppet

