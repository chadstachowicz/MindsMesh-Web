		var containerWidth,
			containerHeight;
			
		function checkContainerResize() {
			var $container = $('#my_id'),
				width = $container.width(),
				height = $container.height();
				
			if (containerWidth === undefined || containerHeight == undefined) {
				containerWidth = width;
				containerHeight = height;
			} 
			if (width != containerWidth || height != containerHeight) {
				
				containerWidth = width;
				containerHeight = height;
				reflowChart();
			}
		}
		
		function reflowChart () {
			var i = options.series.length;
			while (i--) {
				options.series[i].animation = false; 
			}
			chart = new Highcharts.Chart(options);
		}
		
		$(window).load(function() {
			setInterval(checkContainerResize, 1000);
		});
		// End automatic resize mod