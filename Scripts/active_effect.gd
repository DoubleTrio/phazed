class_name ActiveEffect


var on_before_action_queue: DS.PriorityQ = DS.PriorityQ.new([])
var on_action_queue: DS.PriorityQ = DS.PriorityQ.new([])
var on_after_action_end_queue: DS.PriorityQ = DS.PriorityQ.new([])
var on_map_turn_start_queue: DS.PriorityQ = DS.PriorityQ.new([])
var on_map_turn_end_queue: DS.PriorityQ = DS.PriorityQ.new([])
