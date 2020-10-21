INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock simple wind rule with one condition', 'AND', 'device1', 'shutdown');

INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock simple wind rule with two conditions', 'AND', 'device1', 'shutdown');

INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock simple wind rule with two conditions [OR]', 'OR', 'device2', 'shutdown');

INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock parent wind rule with two child rules [OR]', 'OR', 'device2', 'shutdown');

INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock low temperature rule', 'AND', 'device3', 'shutdown');

update rule_definition set PARENT = (select id from rule_definition where name = 'Mock parent wind rule with two child rules [OR]')
	where name = 'Mock simple wind rule with one condition';

INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock Wind Beaufort scale', 'AND', 'device3', 'shutdown');

update rule_definition set PARENT = (select id from rule_definition where name = 'Mock low temperature rule')
	where name = 'Mock Wind Beaufort scale';

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE])
    VALUES ('Wind Speed', '>', '38 mph');

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE])
    VALUES ('Wind Speed', '>', '15 mph');

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE])
    VALUES ('Precipitation', '>', '15 mm');

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE])
    VALUES ('Atmospheric Pressure', '<', '970 MB');

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE])
    VALUES ('Temperature', '<', '-20 c');

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE])
    VALUES ('Wind Speed', '>=', '10 Beaufort');

INSERT INTO [dbo].[rule_definition_condition]([RULE_ID], [CONDITION_ID])
	VALUES(
	    (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with one condition'),
	    (SELECT ID FROM [rule_condition] WHERE [FIELD] = 'Wind Speed' AND [OPERATOR] = '>' AND [VALUE] = '38 mph')
	)
	
INSERT INTO [dbo].[rule_definition_condition]([RULE_ID], [CONDITION_ID])
	VALUES(
	    (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions'),
	    (SELECT ID FROM [rule_condition] WHERE [FIELD] = 'Wind Speed' AND [OPERATOR] = '>' AND [VALUE] = '15 mph')
	)

INSERT INTO [dbo].[rule_definition_condition]([RULE_ID], [CONDITION_ID])
	VALUES(
	    (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions'),
	    (SELECT ID FROM [rule_condition] WHERE [FIELD] = 'Precipitation' AND [OPERATOR] = '>' AND [VALUE] = '15 mm')
	)

INSERT INTO [dbo].[rule_definition_condition]([RULE_ID], [CONDITION_ID])
	VALUES(
	    (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions [OR]'),
	    (SELECT ID FROM [rule_condition] WHERE [FIELD] = 'Wind Speed' AND [OPERATOR] = '>' AND [VALUE] = '38 mph')
	)

INSERT INTO [dbo].[rule_definition_condition]([RULE_ID], [CONDITION_ID])
	VALUES(
	    (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions [OR]'),
	    (SELECT ID FROM [rule_condition] WHERE [FIELD] = 'Atmospheric Pressure' AND [OPERATOR] = '>' AND [VALUE] = '970 MB')
	)

INSERT INTO [dbo].[rule_definition_condition]([RULE_ID], [CONDITION_ID])
	VALUES(
	    (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock Wind Beaufort scale'),
	    (SELECT ID FROM [rule_condition] WHERE [FIELD] = 'Wind Speed' AND [OPERATOR] = '>=' AND [VALUE] = '10 Beaufort')
	)

