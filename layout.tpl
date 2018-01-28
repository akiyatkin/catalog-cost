{layout-cost:}
	<div style="margin-top:5px; border-bottom:1px solid #ddd">
		<style scoped>
			.costslide {
				margin-bottom:10px;
			}
			#costslider{~key} .noUi-connect {
				background-color:#00809e;
			}
			#costslider{~key} {
				margin-left:10px;
				margin-right:10px;
			}
		</style>
		<div>
			<label style="font-weight:bold; font-size:18px">
			  {data.count!count?:box}
			  Цена,&nbsp;руб.&nbsp;<small>{filter}</small>
			</label>
		</div>
		<div class="costslide">
			<div class="row" style="margin-bottom:10px; font-size:18px">
				<div class="col-sm-6">
					<input style="width:100%; border:none; border-bottom:1px solid #ddd" id="inpmin{~key}" type="number">
				</div>
				<div class="col-sm-6">
					<input style="width:100%; border:none; border-bottom:1px solid #ddd;" id="inpmax{~key}" type="number">
				</div>
			</div>
			<div id="costslider{~key}"></div>
		</div>
		<div>
			<label>
			  {omit:box}
			  Без цены&nbsp;<small>{omit.filter}</small>
			</label>
		</div>
		<script>
			domready(function(){
				var m = "{data.m}";
				var path = "{path}";
				var min = {min};
				var max = {max};
				var go = function (minval, maxval){
					Ascroll.once = false;
					if ({min} >= minval && {max} <= maxval) {
						Crumb.go('/catalog?m=' + m + ':'+path+'.minmax');
					}else if (minval == maxval) {
						var minv = minval - step;
						var maxv = Number(maxval) + step;
						if (minv < {min}) minv = {min};
						if (maxv > {max}) maxv = {max};
						Crumb.go('/catalog?m=' + m + ':' + path + '.minmax=' + minv + '/' + maxv);
					} else {
						Crumb.go('/catalog?m=' + m + ':' + path + '.minmax='+minval+'/'+maxval);
					}
				}
				var slider = document.getElementById('costslider{~key}');
				noUiSlider.create(slider, {
					start: [{minval}, {maxval}],
					connect: true,	
					animate:true,
					//step:{step},
					range: {
						'min': {min},
						'max': {max}
					}
				});

				var inpmin = document.getElementById('inpmin{~key}');
				var inpmax = document.getElementById('inpmax{~key}');

				slider.noUiSlider.on('update', function( values, handle ) {
					var value = values[handle];
					if ( handle ) { //max
						inpmax.value = Math.round(value);
					} else { //min
						inpmin.value = Math.round(value);
					}
					
				});
				slider.noUiSlider.on('set', function (values) {
					var min = Math.round(values[0]);
					var max = Math.round(values[1]);
					go(min, max);
				});

				inpmax.addEventListener('change', function(){
					slider.noUiSlider.set([null, this.value]);
				});
				inpmin.addEventListener('change', function(){
					slider.noUiSlider.set([this.value, null]);
				});
				
			});	
		</script>
	</div>
	{optval:}
		<option value="{.}">
	
		