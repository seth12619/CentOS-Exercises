class puppet {

	Package { 
		ensure	=>	'installed',
	}
	package { 'vim': }
	package { 'curl': }
	package { 'git': }
	
	user { 'monitor':
		ensure	=>	'present',
		home	=>	'/home/monitor',
		shell	=>	'/bin/bash',
	}
	
	file{ '/home/monitor/scripts/':
		ensure	=>	'directory',
	}
	
	exec{'memory_check':
		command	=>	"/usr/bin/wget -q https://raw.githubusercontent.com/seth12619/CentOS-Exercises/master/memory_check.sh -O /home/monitor/scripts",
		creates	=>	"/home/monitor/scripts",
	}
	
	file{ '/home/monitor/src/':
		ensure	=>	'directory',
	}
	
	file{ '/home/monitor/scripts':
		ensure	=>	'memory_check',
		target	=>	'/home/monitor/src/my_memory_check',
	}
	
	cron{ 'my_memory_check':
		command => '/home/monitor/src/my_memory_check',
		user    => 'monitor',
		hour    => 0,
		minute  => 10,
	}
	
}