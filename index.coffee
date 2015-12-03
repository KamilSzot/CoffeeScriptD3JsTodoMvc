items = [
	{ value: 'Buy milk' }
]

list = d3.select('#d3 #list')
input = d3.select('#d3 input')
	
r = (obs, { enter, update, exit }) ->
	enter && enter.call obs.enter()
	update && update.call obs
	exit && exit.call obs.exit()

make = (cls) ->
	->
		template = d3.select(this).select(cls+'.template').node() 
		el = template.cloneNode(true)
		template.parentNode.insertBefore(el, template)
		d3.select(el).classed template: false		
		el

render = ->
	r list.selectAll('.item:not(.template)').data(items, (d,i)-> d.uid), 
		enter: ->
			@append make '.item'
			.style 'padding-left', 300 
			.style 'opacity', 0 
				.transition()
				.style 'padding-left', 0 
				.style 'opacity', 1 

		update: -> 
			@select 'span' 
			.text (d, i)-> i+" "+d.value	

			@select 'a' 
			.text 'x' 
			.attr 'href', '#' 
			.on 'click', (d, i) ->
				items.splice(i, 1)
				render()
				d3.event.preventDefault()
				
		exit: ->
			@transition()
				.style 'font-size', 0	
				.remove()



render();

input.node().focus();
input
	.on 'keypress', ->
		if d3.event.keyCode == 13
			v = value: input.node().value 
			v.uid = Math.random()
			items.push(v)
			render()
			input.node().value = ''
	


