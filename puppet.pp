class puppet {
	package { 
		ensure => 'installed'
	}
	package { 'vim': }
	package { 'curl': }
	package { 'git': }
	
	
}