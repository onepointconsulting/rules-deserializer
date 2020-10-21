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

update rule_definition set PARENT = (select id from rule_definition where name = 'Mock parent wind rule with two child rules [OR]')
	where name = 'Mock simple wind rule with two conditions';

INSERT INTO rule_definition([NAME], [OPERATOR], [EVENT_TYPE], [EVENT_DATA])
    VALUES ('Mock Wind Beaufort scale', 'AND', 'device3', 'shutdown');

update rule_definition set PARENT = (select id from rule_definition where name = 'Mock low temperature rule')
	where name = 'Mock Wind Beaufort scale';

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE], [RULE_ID])
    VALUES ('Wind Speed', '>', '38 mph', (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with one condition'));

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE], [RULE_ID])
    VALUES ('Wind Speed', '>', '15 mph', (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions'));

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE], [RULE_ID])
    VALUES ('Precipitation', '>', '15 mm', (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions'));

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE], [RULE_ID])
    VALUES ('Atmospheric Pressure', '<', '970 MB', (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock simple wind rule with two conditions [OR]'));

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE], [RULE_ID])
    VALUES ('Temperature', '<', '-20 c', (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock low temperature rule'));

INSERT INTO [dbo].[rule_condition]([FIELD], [OPERATOR], [VALUE], [RULE_ID])
    VALUES ('Wind Speed', '>=', '10 Beaufort', (SELECT ID FROM rule_definition WHERE [NAME] = 'Mock Wind Beaufort scale'));