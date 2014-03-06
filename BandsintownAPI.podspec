Pod::Spec.new do |s|
	s.name					=	'BandsintownAPI'
	s.version				=	'1.0.0'
	s.platform			= :ios
	s.license				=	'LGPL'
	s.summary				= 'Objective-C wrapper for the Bandsintown API'
	s.homepage			=	'https://github.com/adamcumiskey/BandsintownAPI'
	s.authors				= { 'Adam Cumiskey' => 'adam.cumiskey@gmail.com' }
	s.source				= { :git => 'https://github.com/adamcumiskey/BandsintownAPI.git', :tag => '1.0.0' }
	s.source_files	=	'BandsintownAPI/*'
	s.requires_arc  = true
	s.dependency 'JSONKit', '~> 1.4'
end
