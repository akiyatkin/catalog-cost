{layout-cost:}asdf
{root:}
	{~length(data.md.group)?data.list.Цена:block}
	
{costlabel:}Цена,&nbsp;руб.
{costlabelno:}не&nbsp;указана
{block:}
	<div style="margin-top:5px; border-bottom:1px solid #ddd">
		<style scoped>
			.costslide {
				margin-bottom:10px;
			}
			#costslider{prop_nick} .noUi-connect {
				background-color: var(--primary);
			}
			#costslider{prop_nick} {
				margin-left:10px;
				margin-right:10px;
			}
		</style>
		<div>
			<label class="d-flex justify-content-between" style="font-weight:bold; font-size:16px">
			  <span>
			  	<!-- id add label checked-->
			  	{:costlabel}
				{~objasdf(:id,:costyes,:add,:more.Цена.yes,:label,:costlabel,:checked,data.md.more.Цена.yes):box}
				</span>
			  <span style="font-weight:normal; font-size:14px">
			  	{~obj(:id,:costno,:add,:more.Цена.no,:label,:costlabelno,:checked,data.md.more.Цена.no):box}
				</span>
			</label>
		</div>
		<div class="costslide">
			<div class="row" style="margin-bottom:10px; font-size:18px">
				<div class="col-sm-6">
					<input style="width:100%; border:none; border-bottom:1px solid #ddd; padding-left:4px" id="inpmin{prop_nick}" type="text">
				</div>
				<div class="col-sm-6">
					<input style="width:100%; border:none; border-bottom:1px solid #ddd; padding-left:4px" id="inpmax{prop_nick}" type="text">
				</div>
			</div>
			<div id="costslider{prop_nick}"></div>
		</div>
		<div>
			<label>
			  
			</label>
		</div>
		<script>
			domready(function(){
				var m = "{data.m}";
				var path = "more.{prop_nick}";
				var min = {min|:0};
				var max = {max|:100};
				var origminval = {minval|:0};
				var origmaxval = {maxval|:100};
				var step = {step|:10};
				var go = function (minval, maxval){
					Ascroll.once = false;
					if (min >= minval && max <= maxval) {
						Crumb.go('/catalog?m=' + m + ':'+path+'.minmax');
					}else if (minval == maxval) {
						var minv = minval - step;
						var maxv = Number(maxval) + step;
						if (minv < min) minv = min;
						if (maxv > max) maxv = max;
						Crumb.go('/catalog?m=' + m + ':' + path + '.minmax=' + minv + '/' + maxv);
					} else {
						Crumb.go('/catalog?m=' + m + ':' + path + '.minmax='+minval+'/'+maxval);
					}
				}
				var slider = document.getElementById('costslider{prop_nick}');
				noUiSlider.create(slider, {
					start: [origminval, origmaxval],
					connect: true,	
					animate:true,
					step:step,
					range: {
						'min': min,
						'max': max
					}
				});

				var inpmin = document.getElementById('inpmin{prop_nick}');
				var inpmax = document.getElementById('inpmax{prop_nick}');

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
		<option value="{.}"></option>
	{box:}
		<!-- id add label checked-->
		<div style="cursor:pointer" class="custom-control custom-checkbox">
			<input onchange="Ascroll.once = false; Crumb.go('/catalog{:cat.mark.add}{add}{checked??:one}')" {checked?:checked} type="checkbox" class="custom-control-input" id="box{id}">
			<label class="custom-control-label" for="box{id}">{label}</label>
		</div>
	<!--<input style="cursor:pointer" onchange="Ascroll.once = false; Crumb.go('/catalog{:cat.mark.add}{add}')" {checked?:checked} type="checkbox">-->
	{one:}=1
	{cat::}-catalog/cat.tpl