run_all_in_parallel:
	make -j test_Windows_11_edge_103 test_OX_X_10_11_firefox_101 test_Windows_10_chrome_103

test_Windows_11_edge_103:
	robot -x 'outputxunit.xml' --variable platform:"Windows 11" --variable browserName:MicrosoftEdge --variable version:103 --variable ROBOT_BROWSER:chrome --variable visual:true --variable network:false --variable console:true --outputdir Results/Edge 'rf-tests/Find A Dealer.robot'

test_OX_X_10_11_firefox_101:
	robot -x 'outputxunit.xml' --variable platform:"Windows 11" --variable browserName:firefox --variable version:101 --variable ROBOT_BROWSER:firefox --variable visual:true --variable network:false --variable console:true --outputdir Results/firefox	'rf-tests/Find A Dealer.robot'

test_Windows_10_chrome_103:
	robot -x 'outputxunit.xml' --variable platform:"Windows 10" --variable browserName:chrome --variable version:103 --variable ROBOT_BROWSER:chrome --variable visual:true --variable network:false --variable console:true --outputdir Results/Chrome	'rf-tests/Find A Dealer.robot'