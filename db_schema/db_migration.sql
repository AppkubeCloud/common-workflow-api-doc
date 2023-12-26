CREATE TABLE
	projects_table (
		id UUID DEFAULT gen_random_uuid () PRIMARY KEY,
		project JSONB
	);

CREATE TABLE
	resources_table (
		id UUID DEFAULT gen_random_uuid () PRIMARY KEY,
		resource JSONB
	);

CREATE TABLE
	usecases_table (
		id UUID DEFAULT gen_random_uuid () PRIMARY KEY,
		project_id UUID,
		usecase JSONB
	);

ALTER TABLE usecases_table
ADD CONSTRAINT fk_usecase_project_id FOREIGN KEY (project_id) REFERENCES projects_table (id);

CREATE TABLE
	tasks_table (
		id UUID DEFAULT gen_random_uuid () PRIMARY KEY,
		usecase_id UUID,
		project_id UUID,
		assignee_id UUID,
		stage VARCHAR(20),
		task JSONB
	)
ALTER TABLE tasks_table
ADD CONSTRAINT fk_task_usecase_id FOREIGN KEY (usecase_id) REFERENCES usecases_table (id),
ADD CONSTRAINT fk_task_project_id FOREIGN KEY (project_id) REFERENCES projects_table (id),
ADD CONSTRAINT fk_task_assignee_id FOREIGN KEY (assignee_id) REFERENCES resources_table (id);

CREATE TABLE
	workflows_table (
		id UUID DEFAULT gen_random_uuid () PRIMARY KEY,
		workflow JSONB
	)
ALTER TABLE usecases_table
ADD COLUMN workflow_id UUID;

ALTER TABLE usecases_table
ADD CONSTRAINT fk_usecase_workflow_id FOREIGN KEY (workflow_id) REFERENCES workflows_table (id);