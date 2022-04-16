extends Object
class_name Rule

var subject = EntityEnum.TEXT_BABA
var predicate = EntityEnum.PRED_YOU

const TEXT_OFFSET = EntityEnum.TEXT_BABA - EntityEnum.BABA

func _init(subj=EntityEnum.TEXT_BABA, pred=EntityEnum.PRED_YOU):
	subject = subj
	predicate = pred

func format():
	var rule_text = ""
	match subject:
		EntityEnum.TEXT_BABA:
			rule_text += "Baba"
		EntityEnum.TEXT_WALL:
			rule_text += "Wall"
		EntityEnum.TEXT_FLAG:
			rule_text += "Flag"
		_:
			rule_text += "<ERROR>"
	rule_text += " is "
	match predicate:
		EntityEnum.PRED_STOP:
			rule_text += "Stop"
		EntityEnum.PRED_WIN:
			rule_text += "Win"
		EntityEnum.PRED_YOU:
			rule_text += "You"
		_:
			rule_text += "<ERROR>"
	return rule_text

func matches_subject(entity):
	# could be stuff like "ALL" or "TEXT", but not in this demo
	return entity + TEXT_OFFSET == subject
