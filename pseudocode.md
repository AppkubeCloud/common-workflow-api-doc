# Workflow Management
Welcome to the documentation for the upcoming APIs that will power our workflow management system. In this document, we'll explore the pseudocode for various APIs.

## Project Overview
This project is designed to facilitate efficient workflow management by organizing components into distinct folders. Each folder represents a key aspect of the system, and APIs are developed using Node.js to handle the functionality within each category.

## Folder Structure

The project is structured into multiple folders, each representing a distinct aspect of the WORKFLOW functionalities:

**1. dashboard:** APIs related to the dashboard functionality.

**2. projects:** APIs for managing projects.

**3. workflow:** Handles workflow-related APIs.

**4. usecase:** Manages use case APIs.

**5. task:** APIs for task management.

**6. resource:** Deals with resource-related functionalities.

## Common Logic For All APIs
- Define a Lambda function handler that takes an event as a parameter.
- Import the PostgreSQL Client module.
- Create a new PostgreSQL Client instance database credentails.
- Attempt connection to database. Log success or error for the connection
- Parse request body data from the event object ( if there is a request body)
- Using the pg client create the SQL query required by the API in a try-catch block.
- On successfull query, return the data (if any) with a status code 200 and a success message.
- If there's an error during the database query, log the error and return a response with a status code 500 and a JSON body including an error message.

## API Documentation:

Detailed documentation for each API, including descriptions, endpoints, request parameters, response formats is provided within their respective folders.

### Dashboard

#### 1.getOrgProjectDetails

##### API Description:

The getOrgProjectDetails API retrieves various details about projects within an organization, including total projects, total tasks, percentage completed, and projects grouped by status.

##### Endpoint:
- Method: GET
- Path: /org_projects_overview 

##### Response:
- Success Response (HTTP 200):
  - Body:
    {
        "total_projects": int,
        "total_tasks": int,
        "percentage_completed": int,
        "completed": int,
        "in_progress": int,
        "unassigned": int
    }
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error", "error": "error message" }

##### Pseudocode for getOrgProjectDetails API:
1. Connect to the database.
2. Query the database to get the total number of projects.
3. Query the database to get the total number of tasks.
4. Query the database to get the count of projects grouped by status (completed, in progress, unassigned).
5. Calculate the percentage of completed projects.
6. Return a 200 OK response with the retrieved data.
7. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with error details.

#### 2.getProjectsUsecaseOverview

##### API Description:
The getProjectsUsecaseOverview API retrieves an overview of use cases for projects, including the count of completed and incomplete use cases.

##### Endpoint:
- Method: GET
- Path: /projects_usecase_overview

##### Request Parameters:
- project_id (optional): string - The unique identifier of the project to filter use cases by.

##### Response:
- Success Response (HTTP 200):
  - Body: Array of objects containing project_id, project_name, completed, and incomplete counts.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error", "error": "error message" }

##### Pseudocode for getProjectsUsecaseOverview API:
1. Parse the query parameter "project_id" from the request, if provided.
2. Connect to the database.
3. Construct the SQL query to retrieve project_id, project_name, use case count, and count of completed use cases.
4. If project_id is provided, add a WHERE clause to filter by project_id.
5. Execute the query and retrieve the result.
6. Map the result rows to the desired format containing project_id, project_name, completed, and incomplete counts.
7. Return a 200 OK response with the use case overview data.
8. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with error details.

#### 3.getResourcesTasksStatus

##### API Description:
The getResourcesTasksStatus API retrieves the status of tasks for resources, including the count of completed, in-progress, and pending tasks.

##### Endpoint:
- Method: GET
- Path: /resources_tasks_status

##### Request Parameters:
- resource_id (optional): string - The unique identifier of the resource to filter tasks by.

##### Response:
- Success Response (HTTP 200):
  - Body: Array of objects containing resource_id, resource_name, completed_tasks, inprogress_tasks, and pending_tasks counts.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error", "error": "error message" }

##### Pseudocode for getResourcesTasksStatus API:
1. Parse the query parameter "resource_id" from the request, if provided.
2. Validate the resource_id using a UUID schema.
3. If resource_id validation fails:
   - Return a 400 Bad Request response with the validation error message.
4. Connect to the database.
5. Construct the SQL query to retrieve resource_id, resource_name, and counts of completed, in-progress, and pending tasks.
6. If resource_id is provided, add a WHERE clause to filter by resource_id.
7. Execute the query and retrieve the result.
8. Map the result rows to the desired format containing resource_id, resource_name, completed_tasks, inprogress_tasks, and pending_tasks counts.
9. Return a 200 OK response with the resource tasks status data.
10. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with error details.

#### 4.getProjectsOverview:

##### API Description:
The getProjectsOverview API retrieves an overview of projects, including project details and task completion percentage.

**Endpoint:**
- Method: GET
- Path: /projects_overview

##### Request Parameters:
- status (optional): string - The status of projects to filter by. Allowed values: "unassigned", "completed", "inprogress".

##### Response:
- Success Response (HTTP 200):
  - Body: Array of objects containing project_id, project_name, status, total_usecases, due_date, and completed_tasks_percentage.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error", "error": "error message" }

##### Pseudocode for getProjectsOverview API:
1. Parse the query parameter "status" from the request, if provided.
2. Validate the status parameter against a predefined list of valid values.
3. If status validation fails:
   - Return a 400 Bad Request response with the validation error message.
4. Connect to the database.
5. Construct the SQL query to retrieve project details and task completion percentage.
6. If status is provided, add a WHERE clause to filter projects by status.
7. Execute the query and retrieve the result.
8. Map the result rows to the desired format containing project details and completion percentage.
9. Return a 200 OK response with the projects overview data.
10. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with error details.

#### 5.getProjectResourceOverview

##### API Description:
The getProjectResourceOverview API retrieves an overview of resources assigned to projects, including resource details and tasks.

##### Endpoint:
- Method: GET
- Path: /projects_resource_overview

##### Request Parameters:
- status (optional): string - The status of projects to filter by. Allowed values: "unassigned", "completed", "inprogress".

##### Response:
- Success Response (HTTP 200):
  - Body: Array of objects containing project_id, project_name, and project_resources (an array of resource objects).
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error", "error": "error messag  e" }

##### Pseudocode for getProjectResourceOverview API:
1. Parse the query parameter "status" from the request, if provided.
2. Validate the status parameter against a predefined list of valid values.
3. If status validation fails:
   - Return a 400 Bad Request response with the validation error message.
4. Connect to the database.
5. Construct the SQL query to retrieve project details along with team members and their tasks.
6. If status is provided, add a WHERE clause to filter projects by status.
7. Execute the query and retrieve the result.
8. Map the result rows to the desired format containing project details and resources with their tasks.
9. Return a 200 OK response with the project resource overview data.
10. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with error details.

### Projects

#### 1.addProject:

##### API Description:
The addProject API allows users to add a new project to the system.

##### Endpoint:
- Method: POST
- Path: /project

##### Request Body:
- name: string (required) - The name of the project.
- description: string (required) - Description of the project.
- department: string (required) - The department associated with the project.
- start_date: string (required) - Start date of the project.
- end_date: string (required) - End date of the project.
- image_url: string (required) - URL of the project icon image.

##### Responce:
- Success Response (HTTP 200):
  - Body: JSON object representing the newly added project.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error", "error": "error message" }

##### Pseudocode for addProject API:
1. Parse the request body to extract project details.
2. Validate the request body against the defined schema using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Connect to the database.
5. Check if a project with the same name already exists in the database.
6. If a duplicate project name is found:
   - Return a 400 Bad Request response with an appropriate error message.
7. Construct the project object with the provided details.
8. Insert the project into the projects_table in the database.
9. Extract the inserted project data along with its ID.
10. Return a 200 OK response with the inserted project data.
11. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with error details.

#### 2.addTeamToProject:

##### API Description:
The addTeamToProject API allows users to add a team to a specific project.

##### Endpoint:
- Method: PUT
- Path: /project/{id}/team

##### Request Body:
- team_name: string (required) - The name of the team to be added.
- created_by_id: string (required) - The ID of the user who created the team.
- roles: array (required) - Array of team roles, each containing role name and associated user IDs.

##### Path Parameters:
- project_id: string (required) - The ID of the project to which the team will be added.

##### Responce:
- Success Response (HTTP 200):
  - Body: { "message": Team added to the project}
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error"}

##### Pseudocode for addTeamToProject API:
1. Parse the project_id from the path parameters.
2. Validate the project_id against the UUID schema using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Parse the request body to extract team details.
5. Validate the request body against the defined schema using Zod.
6. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
7. Connect to the database.
8. Construct the update query to add the team to the specified project.
9. Execute the query with the provided team and project_id.
10. If successful, return a 200 OK response with a success message.
11. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with an error message.

#### 3.getProject:

##### API Description:
The getProject API retrieves details of a specific project including its name, description, last update time, and associated workflows with their respective statistics.

##### Endpoint:
- Method: GET
- Path: /project/{id}

##### Path Parameters:
- project_id: string (required) - The ID of the project to retrieve details for.

##### Responce:
- Success Response (HTTP 200):
  - Body: JSON object containing project details including name, description, last updated time, and workflows with statistics.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error"}

##### Pseudocode for getProject API:
1. Parse the project_id from the path parameters.
2. Validate the project_id against the UUID schema using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Connect to the database.
5. Retrieve project details including name, description, and last updated time from the projects_table.
6. Retrieve associated workflows with their statistics (total usecases, total tasks, task completion percentage) from the usecases_table and tasks_table.
7. Calculate the task completion percentage for each workflow.
8. Assemble the response object containing project details and workflows information.
9. Return a 200 OK response with the response object.
10. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with an error message.

#### 4.getProjectTeam

##### API Description:
The getProjectTeam API retrieves the team members and their roles associated with a specific project.

##### Endpoint:
- Method: GET
- Path: /project/{id}/team

##### Path Parameters:
- project_id: string (required) - The ID of the project to retrieve team information for.

##### Responce:
- Success Response (HTTP 200):
  - Body: JSON array containing team members with their roles.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error"}

##### Pseudocode for getProjectTeam API:
1. Parse the project_id from the path parameters.
2. Validate the project_id against the UUID schema using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Connect to the database.
5. Query the projects_table to retrieve the team roles associated with the given project_id.
6. If no team roles are found:
   - Return a 200 OK response with an empty array.
7. For each role:
   a. Extract the resource IDs associated with that role.
   b. Query the employee table to retrieve details of resources based on their IDs.
   c. Assemble the response object containing the role name and corresponding resource details.
8. Return a 200 OK response with the response array containing team roles and their members.
9. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with an error message.

#### 5.getProjectWorkflows:

##### API Description:
The getProjectWorkflows API retrieves information about workflows associated with a specific project.

##### Endpoint:
- Method: GET
- Path: /project/{id}/workflow

##### Path Parameters:
- project_id: string (required) - The ID of the project to retrieve workflow information for.

##### Responce:
- Success Response (HTTP 200):
  - Body: JSON array containing workflow details.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error"}

##### Pseudocode for getProjectWorkflows API:
1. Parse the project_id from the path parameters.
2. Validate the project_id against the UUID schema using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Connect to the database.
5. Query the workflows_table to retrieve workflow information associated with the given project_id.
6. Calculate the percentage of completed tasks for each workflow.
7. Assemble the response object containing workflow details.
8. Return a 200 OK response with the response array containing workflow details.
9. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with an error message.

#### 6.getProjects:

##### API Description:
The getProjects API retrieves information about projects based on their status.

##### Endpoint:
- Method: GET
- Path: /project

##### Query Parameters:
- status: string (optional) - Filter projects by status. Valid values are "unassigned", "completed", or "inprogress".

##### Responce:
- Success Response (HTTP 200):
  - Body: JSON array containing project details.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error"}

##### Pseudocode for getProjects API:
1. Parse the status parameter from the query string.
2. Validate the status parameter against the list of valid status values using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Connect to the database.
5. Construct the SQL query to retrieve project information based on the provided status parameter.
6. Execute the query and retrieve the results.
7. Process the query results and assemble the response object containing project details.
8. Return a 200 OK response with the response array containing project details.
9. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with an error message.

#### 7.projectsResourcesTasksStatus:

##### API Description:
The projectsResourcesTasksStatus API retrieves task status information for resources assigned to a project.

##### Endpoint:
- Method: GET
- Path: /project/{id}/team/status

##### Path Parameters:
- projectId: string (required) - The unique identifier of the project.

##### Responce:
- Success Response (HTTP 200):
  - Body: JSON array containing task status information for resources.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error"}

##### Pseudocode for projectsResourcesTasksStatus API:
1. Parse the projectId parameter from the path.
2. Validate the projectId parameter as a UUID using Zod.
3. If validation fails:
   - Return a 400 Bad Request response with the validation error details.
4. Connect to the database.
5. Query the database to retrieve roles and project name based on the projectId.
6. If no project is found:
   - Return a 200 OK response with a message indicating no project is present.
7. Extract resourceIds from the roles.
8. If no resourceIds are found:
   - Return a 200 OK response with a message indicating no resource ids are present in the roles.
9. Construct and execute a SQL query to retrieve task status information for resources based on their ids.
10. Process the query results and assemble the response array containing task status information for resources.
11. Return a 200 OK response with the response array.
12. If any error occurs during the process:
    - Catch the error.
    - Return a 500 Internal Server Error response with an error message.

### Workflow

#### 1.addWorkflow

##### API Description:
The addWorkflow API creates a new workflow for a project and deploys it as a Step Functions state machine.

##### Endpoint:
- Method: POST
- Path: /workflow

##### Request Body:
- name: string (required) - The name of the workflow.
- created_by_id: string (required) - The unique identifier of the resource who created the workflow.
- project_id: string (required) - The unique identifier of the project the workflow belongs to.
- stages: array (required) - An array of stages containing tasks and checklists for the workflow.

##### Responce:
- Success Response (HTTP 200):
  - Body: Details of the newly created workflow.
- Error Response (HTTP 500):
  - Body: { "error": "Internal Server Error" } or { "error": "Workflow with same name already exists" } in case of a name conflict.

##### Pseudocode for addWorkflow API:
1. Parse the name, created_by_id, project_id, and stages from the request body.
2. Validate the name to ensure it does not contain `-` and is at least 3 characters long.
3. Validate the project_id as a UUID.
4. Validate the request body structure using Zod.
5. Generate a new unique workflow name with a random UUID prefix.
6. Generate the state machine definition based on the provided stages.
7. Connect to the database.
8. Check if a workflow with the same name already exists for the project.
9. If a duplicate workflow exists, return a 400 Bad Request response.
10. Create a new Step Functions client.
11. Create a new state machine using the generated state machine definition.
12. Insert the new workflow into the workflows_table in the database.
13. Return a 200 OK response with the information about the newly created workflow.
14. If any error occurs during the process:
    - Catch the error.
    - Check if the error is due to a duplicate workflow name.
    - Return an appropriate error response with the error message.

#### 2.deleteWorkflow

##### API Description:
The deleteWorkflow API terminates a workflow by deleting its associated Step Functions state machine.

##### Endpoint:
- Method: DELETE
- Path: /workflow/{id}

##### Request Parameters:
- id: string (required) - The unique identifier of the workflow to be deleted.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object with a success message indicating the workflow deletion and status update.
- Error Response (HTTP 500):
  - Body: { "error": "Internal Server Error" }

##### Pseudocode for deleteWorkflow API:
1. Parse the workflow_id from the request path.
2. Validate the workflow_id as a UUID.
3. Connect to the database.
4. Begin a database transaction.
5. Retrieve the ARN of the workflow from the workflows_table using the workflow_id.
6. Update the status of the workflow to "terminated" in the metadata column of the workflows_table.
7. Create a new Step Functions client.
8. Prepare input for deleting the state machine using the retrieved ARN.
9. Execute the DeleteStateMachineCommand to terminate the state machine.
10. If the update operation is successful, commit the transaction.
11. Return a 200 OK response with a success message.
12. If any error occurs during the process:
    - Rollback the transaction.
    - Catch the error and log it.
    - Return an appropriate error response.

#### 3.generateStateMachine

##### API Description:
The generateStateMachine2 function generates an AWS Step Functions state machine based on the provided stages. It creates a parallel state machine where each stage runs in parallel, and each stage can have multiple tasks running concurrently.

##### Parameters:
stages (array, required): An array of stages, where each stage is an object with the stage name and tasks.

##### Return:
An object representing the generated AWS Step Functions state machine.

#### 4.getAllWorkflows

##### API Description:
The getAllWorkflows API retrieves information about all workflows stored in the database.

##### Endpoint:
- Method: GET
- Path: /workflow

##### Response:
- Success Response (HTTP 200):
  - Body: JSON array containing information about all workflows.
- Error Response (HTTP 400):
  - Body: { "error": "Missing project_id parameter" }
- Error Response (HTTP 500):
  - Body: { "error": "Internal Server Error" }

##### Pseudocode for getAllWorkflows API:
1. Define the SQL query to retrieve information about all workflows, including their stages and creator details.
2. Connect to the database.
3. Execute the SQL query to fetch workflow data.
4. Map the retrieved data to a more structured format for the response.
5. Return a 200 OK response with the structured workflow data.
6. Handle any errors that occur during the process:
   - Log the error.
   - Return an appropriate error response with error details.

#### 5.updateWorkflow

##### API Description:
The updateWorkflow API updates an existing workflow by modifying its stages and metadata.

##### Endpoint:
- Method: PUT
- Path: /workflow/{id}

##### Request Parameters:
- id: string (required) - The unique identifier of the workflow to be updated.

##### Request Body:
- updated_by_id: string (required) - The unique identifier of the user who is updating the workflow.
- stages: array of objects (required) - The updated stages of the workflow, each containing tasks and checklist items.

##### Response:
- Success Response (HTTP 200):
  - Body: Updated workflow details.
- Error Response (HTTP 400):
  - Body: { "error": "Missing workflow id path parameter" }
- Error Response (HTTP 500):
  - Body: { "error": "Workflow with same name already exists" } (if applicable)
  - Body: { "message": "Internal Server Error", "error": "error message" }

##### Pseudocode for updateWorkflow API:
1. Parse the workflow_id from the request path.
2. Parse the updated_by_id and stages from the request body.
3. Validate the workflow_id and updated_by_id as UUIDs.
4. Validate the stages array and its structure.
5. Connect to the database.
6. Retrieve the workflow's ARN and metadata from the workflows_table using the workflow_id.
7. Generate a new state machine definition using the updated stages.
8. Create a new Step Functions client.
9. Prepare input for updating the state machine using the retrieved ARN and the new state machine definition.
10. Execute the UpdateStateMachineCommand to update the state machine.
11. Retrieve information about the user who initiated the update operation.
12. Update the metadata of the workflow with the updated stages and user information.
13. Execute a database query to update the workflow's metadata.
14. Return a 200 OK response with the updated stages of the workflow.
15. If any error occurs during the process:
    - Catch the error and handle it appropriately.
    - Return an appropriate error response.

#### 6. getWorkflow.js

##### API Description:
The getWorkflow API retrieves information about a specific workflow based on its unique identifier.

##### Endpoint
- Method: GET
- Path: /Workflow/{id}

##### Request Parameters:
- id: string (required) - The unique identifier of the workflow to be retrieved.

##### Response
- Success Response (HTTP 200):
  - Body: JSON object containing information about the requested workflow, excluding its ARN.
- Error Responses:
  - HTTP 400 Bad Request: If the provided workflow id is invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for getWorkflow API:
1. Parse the workflow_id from the request path.
2. Validate the workflow_id as a UUID.
3. Connect to the database.
4. Retrieve information about the workflow from the workflows_table using the workflow_id.
5. Modify the response to exclude the ARN and format the workflow name.
6. Return a 200 OK response with the requested workflow information.
7. If any error occurs during the process:
    - Catch the error and handle it appropriately.
    - Return an appropriate error response.

### Usecase

#### 1.addUsecase

##### API Description:
The addUsecase API is used to add a new use case to a project, triggering its execution in the associated workflow state machine.

##### Endpoint:
- Method: POST
- Path: /usecase

##### Request Body:
- project_id: string (required) - The unique identifier of the project to which the use case belongs.
- created_by_id: string (required) - The unique identifier of the user who created the use case.
- usecase_name: string (required) - The name of the use case.
- assigned_to_id: string (required) - The unique identifier of the user to whom the use case is assigned.
- description: string (required) - The description of the use case.
- workflow_id: string (required) - The unique identifier of the workflow associated with the use case.
- start_date: date (required) - The start date of the use case.
- end_date: date (required) - The end date of the use case.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing information about the newly added use case.
- Error Response (HTTP 500):
  - Body: { "message": "internal server error" }

##### Pseudocode for addUsecase API:
1. Parse the request body to extract use case details.
2. Validate the project_id, created_by_id, and workflow_id as UUIDs.
3. If any of the UUID validations fail, return a 400 Bad Request response.
4. Validate the usecase_name, ensuring it meets specified criteria.
5. If the usecase_name validation fails, return a 400 Bad Request response.
6. Generate a unique identifier (UUID) for the new use case.
7. Format the use case name and check if a use case with the same name already exists in the project.
8. If a use case with the same name exists, return a 400 Bad Request response.
9. Create a Step Functions client and prepare input for starting the execution of the workflow state machine.
10. Retrieve the ARN and stages of the workflow associated with the provided workflow_id.
11. Execute the StartExecutionCommand to trigger the execution of the workflow state machine.
12. If the execution is successful, insert the new use case into the usecases_table.
13. Modify the response to format the use case name.
14. Return a 201 Created response with information about the newly added use case.
15. If any error occurs during the process:
    - Catch the error and handle it appropriately.
    - Return an appropriate error response.

#### 2.deleteUsecase

##### API Description:
The deleteUsecase API is used to stop the execution of a use case and update its status to "Stop".

##### Endpoint:
- Method: DELETE
- Path: usecase/{id}

##### Request Parameters:
- id: string (required) - The unique identifier of the use case to be deleted.

##### Response:
- Success Response (HTTP 204):
  - Body: JSON object indicating successful update of use case data..
- Error Response (HTTP 500):
  - Body: { "error": "Internal Server Error" }

##### Pseudocode for deleteUsecase API:
1. Parse the usecase_id from the request path.
2. Validate the usecase_id as a UUID.
3. If the UUID validation fails, return a 400 Bad Request response.
4. Connect to the database and begin a transaction.
5. Retrieve the ARN of the use case from the usecases_table using the usecase_id.
6. Prepare input for stopping the execution of the use case state machine using the retrieved ARN.
7. Update the status of the use case to "Stop" and record the stop date in the usecases_table.
8. Execute the StopExecutionCommand to stop the execution of the use case state machine.
9. If the update operation is successful, commit the transaction.
10. Return a 200 OK response with a success message.
11. If any error occurs during the process:
    - Rollback the transaction.
    - Catch the error and log it.
    - Return an appropriate error response.

#### 3.getUsecase

##### API Description:
The getUsecase API retrieves details of a specific use case.

##### Endpoint:
- Method: GET
- Path: /usecase/{id}

##### Request Parameters:
- id: string (required) - The unique identifier of the use case to be retrieved.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the details of the requested use case.
- Error Response (HTTP 500):
  - Body: { "error": "Internal Server Error" }

##### Pseudocode for getUsecase API:
1. Parse the usecase_id from the request path.
2. Validate the usecase_id as a UUID.
3. If the UUID validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Execute a query to retrieve the details of the use case based on the provided usecase_id.
6. Process the query result and construct the response object.
7. Return a 200 OK response with the constructed response object.
8. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 4.getUsecases

##### API Description:
The getUsecases API retrieves a list of use cases associated with a specific project and workflow.

##### Endpoint:
- Method: GET
- Path: /usecase
- Query Parameters:
  - project_id: ID of the project for which use cases are requested.
  - workflow_id: ID of the workflow for which use cases are requested.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the list of use cases and their details.
    - stages: Array of strings representing the stages in the workflow.
    - usecases: Array of objects representing the use cases with their details.
- Error Response (HTTP 400):
  - Body: { "error": "Missing project_id parameter" } or { "error": "Missing workflow_id parameter" }

##### Pseudocode for getUsecases API:
1. Parse the project_id and workflow_id from the query parameters.
2. Validate both project_id and workflow_id as UUIDs.
3. If any UUID validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Execute a query to retrieve the list of use cases associated with the provided project_id and workflow_id.
6. Process the query result and construct the response object containing stages and use cases.
7. Return a 200 OK response with the constructed response object.
8. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

##### 5.updateUsecase

##### API Description:
The updateUsecase API is used to update an existing use case with new information and stages.

##### Endpoint:
- Method: PUT
- Path: /usecase/{id}

##### Request Parameters:
- id: string (required) - The unique identifier of the use case to be updated.

##### Request Body:
- name: string (required) - The updated name of the use case.
- updated_by_id: string (required) - The unique identifier of the user who updated the use case.
- stages: array (required) - The updated stages of the use case, each containing tasks and a checklist.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the updated stages.
- Error Response (HTTP 400):
  - Body: { "error": "Missing useCaseId parameter" } or error details.

##### Pseudocode for updateUsecase API:
1. Parse the use case id from the request path and the name, updated_by_id, and stages from the request body.
2. Validate the use case id and updated_by_id as UUIDs.
3. Validate the request body schema for name and stages.
4. If any validation fails, return a 400 Bad Request response.
5. Connect to the database.
6. Retrieve details of the user who updated the use case.
7. Retrieve the existing data of the use case and its associated tasks.
8. Retrieve the state machine ARN associated with the use case's workflow.
9. Generate a new state machine definition based on the updated stages.
10. Update the state machine with the new definition.
11. Generate a new name for the use case if needed.
12. Start the execution of the updated state machine with the new name.
13. Update the use case in the database with the new ARN and updated data.
14. Return a 200 OK response with the updated stages.
15. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 6.getUsecaseForm:

##### API Description:
The getUsecaseForm API is used to fetch the details of a use case along with its associated tasks grouped by stages for rendering a form.

##### Endpoint:
- Method: GET
- Path: /usecase/{id}/form

##### Request Parameters:
- id: string (optional) - The unique identifier of the use case for which the form details are requested.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the details of the use case along with its associated tasks grouped by stages.
- Error Response:
  - HTTP 400 Bad Request: If the provided use case id is invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for getUsecaseForm API:
1. Parse the use case id from the request path.
2. Validate the use case id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Fetch the details of the use case and its associated tasks grouped by stages.
6. Transform the fetched data into the required format for rendering the form.
7. Return a 200 OK response with the form details.
8. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 7.getUsecaseAsset:

##### API Description:
The getUsecaseAsset API is used to fetch the documents associated with tasks in a use case, grouped by stages.

##### Endpoint:
- Method: GET
- Path: /usecase/{id}/asset

##### Request Parameters:
- id: string (optional) - The unique identifier of the use case for which the documents are requested.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the documents associated with tasks grouped by stages.
- Error Response:
  - HTTP 400 Bad Request: If the provided use case id is invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for getUsecaseAsset API:
1. Parse the use case id from the request path.
2. Validate the use case id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Fetch the documents associated with tasks in the use case, grouped by stages.
6. Transform the fetched data into the required format.
7. Return a 200 OK response with the documents grouped by stages.
8. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 8.getUsecasePlanning:

##### API Description:
The getUsecasePlanning API is used to fetch the planning details of tasks within a use case, including deviations in start and end dates.

##### Endpoint:
- Method: GET
- Path: /usecase/{id}/planning

##### Request Parameters:
- id: string (optional) - The unique identifier of the use case for which the planning details are requested.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the planning details of tasks within the use case, including deviations in start and end dates.
- Error Response:
  - HTTP 400 Bad Request: If the provided use case id is invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for getUsecasePlanning API:
1. Parse the use case id from the request path.
2. Validate the use case id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Fetch the planning details of tasks within the use case, including deviations in start and end dates.
6. Transform the fetched data into the required format.
7. Return a 200 OK response with the planning details of tasks within the use case.
8. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 9.assignStage:

##### API Description:
The assignStage API is used to assign a user to a specific stage within a use case.

##### Endpoint:
- Method: PUT
- Path: /usecase/{id}/assignStage

##### Request Body:
- stage_name: string - The name of the stage to which the user will be assigned.
- assigned_to_id: string - The unique identifier of the user to be assigned.
- description: string (optional) - The description of the stage.

##### Request Parameters:
- id: string (optional) - The unique identifier of the use case to which the stage assignment belongs.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object with a success message indicating that the stage was assigned successfully.
- Error Response:
  - HTTP 400 Bad Request: If the provided use case id is invalid or the use case is not found.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for assignStage API:
1. Parse the use case id from the request path and request body parameters.
2. Validate the use case id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Retrieve the existing data of the use case from the database.
6. Update the assigned user and description for the specified stage in the existing data.
7. Update the use case in the database with the modified data.
8. Return a 200 OK response with a success message.
9. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 10.updateChecklist:

##### API Description:
The updateChecklist API is used to update the status of a checklist item in a specific stage of a use case.

##### Endpoint:
- Method: PUT
- Path: /usecase/{id}/checklist

##### Request Body:
- stage_name: string - The name of the stage containing the checklist item.
- item_id: number - The identifier of the checklist item to be updated.
- checked: boolean - The new status of the checklist item.

##### Request Parameters:
- id: string - The unique identifier of the use case containing the stage with the checklist item.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the updated checklist item.
- Error Response:
  - HTTP 400 Bad Request: If the provided use case id is invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for updateChecklist API:
1. Parse the use case id from the request path and the stage name, item id, and checked status from the request body.
2. Validate the use case id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Validate the request body parameters (stage name, item id, checked status).
5. If the validation fails, return a 400 Bad Request response.
6. Connect to the database.
7. Update the status of the specified checklist item in the specified stage of the use case.
8. Retrieve the updated checklist item.
9. Return a 200 OK response with the updated checklist item.
10. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

#### 11.getUsecaseTask:

##### API Description:
The getUsecaseTask API retrieves the tasks associated with each stage of a specific use case.

##### Endpoint:
- Method: GET
- Path: /usecase/{id}/task

##### Request Parameters:
- id: string - The unique identifier of the use case for which tasks are to be retrieved.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the tasks associated with each stage of the use case.
- Error Response:
  - HTTP 400 Bad Request: If the provided use case id is invalid.
  - HTTP 404 Not Found: If no tasks are found for the specified use case id.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for getUsecaseTask API:
1. Parse the use case id from the request path.
2. Validate the use case id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Retrieve the use case data including its stages from the database.
6. If no data is found for the specified use case id, return a 404 Not Found response.
7. Extract the assignee ids from the use case data.
8. Query the database to retrieve details of the employees assigned to the stages.
9. For each stage in the use case data:
    - Retrieve the tasks associated with that stage from the database.
    - For each task, construct an object containing task details including assignee details and associated documents.
10. Return a 200 OK response with the use case data containing tasks associated with each stage.
11. If any error occurs during the process:
    - Catch the error and log it.
    - Return an appropriate error response.

### Task

#### 1.addComment

##### API Description:
The addComment API allows users to add comments to a specific task.

##### Endpoint:
- Method: PUT
- Path: /task/{id}/comment

##### Request Parameters:
- id: string - The unique identifier of the task to which the comment will be added.

##### Request Body:
- id: string - The unique identifier of the resource adding the comment.
- comment: string - The comment to be added to the task.

##### Response:
- Success Response (HTTP 200):
  - Body: "Comment added"
- Error Response (HTTP 400/500):
  - Body: { "error": "Missing task_id parameter" } (HTTP 400) or { "error": "Internal Server Error" } (HTTP 500)

##### Pseudocode for addComment API:
1. Parse the task_id from the request path.
2. If the task_id is missing, return a 400 Bad Request response.
3. Connect to the database.
4. Extract the id and comment from the request body.
5. Query the database to retrieve details of the resource adding the comment.
6. Construct a JSON object containing the comment details including the resource, comment, created date, and reply.
7. Update the comments field of the specified task with the new comment.
8. Return a 200 OK response with the message "comment added".
9. If any error occurs during the process:
    - Catch the error and log it.
    - Return a 500 Internal Server Error response.
10. Finally, close the database connection.

#### 2.completeTask

##### API Description:
The completeTask API allows marking a specific task as completed and sending a success response to a Step Functions task.

##### Endpoint:
- Method: PUT
- Path: /task/{taskId}/complete

##### Query Parameters:
- task_id (required): The ID of the task to be marked as completed.

##### Response:
- Success Response (HTTP 200):
  - Body: { "message": "Task completed" }
- Error Responses (HTTP 400/404/500):
  - Body: { "message": "task id is required" } (HTTP 400)
  - Body: { "message": "Task not found" } (HTTP 404)
  - Body: { "error": "Internal Server Error", "message": "..." } (HTTP 500)

##### Pseudocode for completeTask API:
1. Parse the task_id from the query parameters.
2. Validate the task_id as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Define the updateQuery to mark the specified task as completed.
6. Define the getTokenQuery to retrieve the task token and usecase_id associated with the task.
7. Begin a transaction with the database.
8. Query the database to retrieve the task token and usecase_id.
9. Create a Step Functions client.
10. Prepare input for the Step Functions task with the output set to the usecase_id and the taskToken set to the retrieved token.
11. Send a success response to the Step Functions task using the SendTaskSuccessCommand.
12. Update the status of the task in the database to "completed".
13. If the update is successful, commit the transaction.
14. Return a 200 OK response with the message "task completed".
15. If any error occurs during the process:
    - Rollback the transaction.
    - Catch the error, log it, and return a 500 Internal Server Error response.
16. Finally, close the database connection.

#### 3. assignTask

##### API Description:
The assignTask API allows assigning a task to a specific resource.

##### Endpoint:
- Method: PUT
- Path: /task/{taskId}/assign/{resourceId}

##### Path Parameters:
- taskId: string - The unique identifier of the task to be assigned.
- resourceId: string - The unique identifier of the resource to whom the task will be assigned.

##### Response:
- Success Response (HTTP 201):
  - Body: JSON object with the message "task assigned successfully".
- Error Response:
  - HTTP 400 Bad Request: If the task id or resource id is missing or invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for assignTask API:
1. Parse the taskId and resourceId from the path parameters.
2. Validate the taskId and resourceId as UUIDs.
3. If the validation fails for either taskId or resourceId, return a 400 Bad Request response.
4. Connect to the database.
5. Define the update query to assign the task to the specified resource.
6. Execute the update query with the assigned_to_id and task_id.
7. If no records are updated, return a 400 Bad Request response with the message "No matching records found".
8. Return a 201 Created response with the message "task assigned successfully".
9. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
10. Finally, close the database connection.

#### 4. uploadMetaDoc

##### API Description:
The uploadMetaDoc API allows uploading metadata for a document associated with a specific task.

##### Endpoint:
- Method: POST
- Path: /task/{taskId}/doc

##### Path Parameter:
- taskId: string - The unique identifier of the task associated with the document.

##### Request Body:
- doc_name: string - The name of the document.
- doc_url: string - The URL of the document.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON object containing the metadata of the uploaded document.
- Error Response:
  - HTTP 400 Bad Request: If the taskId is missing or invalid, or if the request body is missing or contains invalid data.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for uploadMetaDoc API:
1. Parse the taskId from the path parameters.
2. Validate the taskId as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Parse the doc_name and doc_url from the request body.
5. Validate the doc_name as a string and doc_url as a valid URL.
6. If the validation fails for either doc_name or doc_url, return a 400 Bad Request response.
7. Connect to the database.
8. Define the insert query to upload metadata for the document.
9. Execute the insert query with the task_id, created_by, doc_name, doc_url, and currentTimestamp.
10. Return a 200 OK response with the metadata of the uploaded document.
11. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
12. Finally, close the database connection.

#### 5. deleteMetaDoc

##### API Description:
The deleteMetaDoc API allows deleting metadata for a specific document.

##### Endpoint:
- Method: DELETE
- Path: /task/{taskId}/docs/{docId}

##### Path Parameter:
- id: string - The unique identifier of the document to be deleted.

##### Response:
- Success Response (HTTP 204 No Content):
  - Body: Empty
- Error Response:
  - HTTP 400 Bad Request: If the document id is missing or invalid.
  - HTTP 500 Internal Server Error: If any error occurs during the deletion process.

##### Pseudocode for deleteMetaDoc API:
1. Parse the documentId from the path parameters.
2. Validate the documentId as a UUID.
3. If the validation fails, return a 400 Bad Request response.
4. Define the delete query to remove the metadata for the specified document.
5. Connect to the database.
6. Execute the delete query with the documentId.
7. Return a 204 No Content response indicating successful deletion.
8. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
9. Finally, close the database connection.

#### 6. addReply

##### API Description:
The addReply API allows adding a reply to a comment associated with a task.

##### Endpoint:
- Method: PUT
- Path: /task/{taskId}/reply

##### Path Parameter:
- id: string - The unique identifier of the task to which the reply is added.

##### Request Body:
- resource_id: string - The unique identifier of the resource adding the reply.
- comment: string - The content of the reply.
- commentIndex: number - The index of the comment to which the reply is added.

##### Response:
- Success Response (HTTP 200 OK):
  - Body: "updated reply success"
- Error Response:
  - HTTP 400 Bad Request: If the task id or resource id is missing or invalid, or if the commentIndex is less than 0.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for addReply API:
1. Parse the taskId from the path parameters.
2. Parse the resource_id, comment, and commentIndex from the request body.
3. Validate the taskId and resource_id as UUIDs.
4. Validate the commentIndex to ensure it is a non-negative number.
5. If any validation fails, return a 400 Bad Request response with appropriate error messages.
6. Retrieve the resource details from the database using the resource_id.
7. Construct the reply object containing resource details, comment, and created_date.
8. Define the update query to add the reply to the comments array of the task.
9. Connect to the database.
10. Execute the update query with the taskId, commentIndex, and reply object.
11. Return a 200 OK response with the message "updated reply success" upon successful update.
12. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
13. Finally, close the database connection.

### Resource

#### 1. addResource

##### API Description:
The addResource API allows adding a new resource to the system.

##### Endpoint
- Method: POST
- Path:/resource

##### Request Body:
- resource_name: string - The name of the resource.
- email: string - The email address of the resource.
- role: string - The role of the resource.
- project: string - The project associated with the resource.
- description: string - The description of the resource.

##### Response:
- Success Response (HTTP 200 OK):
  - Body: JSON object containing the newly added resource details.
- Error Response:
  - HTTP 400 Bad Request: If any of the input fields fail validation.
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for addResource API:
1. Parse the resource_name, email, role, project, and description from the request body.
2. Construct a resource object with the parsed data.
3. Define a schema using Zod to validate the resource object.
4. Validate the resource object against the schema.
5. If validation fails, return a 400 Bad Request response with appropriate error messages.
6. Connect to the database.
7. Insert the resource object into the database table.
8. Retrieve the ID of the newly inserted resource.
9. Append the ID to the resource object.
10. Return a 200 OK response with the newly added resource details.
11. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
12. Finally, close the database connection.

#### 2.getResources

##### API Description:
The getResources API retrieves a list of resources along with their details and associated projects.

##### Endpoint:
- Method: GET
- Path: /resource

##### Request Parameters:
- project_id (optional): string - The unique identifier of the project to filter resources by.

##### Response:
- Success Response (HTTP 200 OK):
  - Body: JSON array containing resource details and associated projects.
- Error Response:
  - HTTP 500 Internal Server Error: If any error occurs during the process.

##### Pseudocode for getResources API:
1. Parse the project_id query parameter from the request.
2. Connect to the database.
3. Define queries to retrieve resources and projects data.
4. Execute the resources query to retrieve all resources.
5. Execute the projects query to retrieve all projects.
6. Process the retrieved data to format it appropriately.
7. If a project_id is provided, filter the resources to include only those associated with the specified project.
8. Construct the response body containing the formatted data.
9. Return a 200 OK response with the formatted data.
10. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
11. Finally, close the database connection.

##### Note:
- The processResourcesData function is responsible for formatting the retrieved resources and projects data.
- It filters resources based on the provided project_id, if any.
- The outputData array contains the formatted resource details along with associated projects.

#### 3.getResourcesByName

##### API Description:
The getResourcesByName API retrieves resources based on their name, optionally filtered by a project.

##### Endpoint:
- Method: GET
- Path: /get_resource_by_name

##### Request Parameters:
- name: string - The name or part of the name of the resource to search for.
- project_id (optional): string - The unique identifier of the project to filter resources by.

##### Response:
- Success Response (HTTP 200):
  - Body: Successful responce.
- Error Response (HTTP 500):
  - Body: { "message": "Internal Server Error" }

##### Pseudocode for getResourcesByName API:
1. Parse the name and project_id query parameters from the request.
2. Connect to the database.
3. Execute a query to retrieve resources based on the provided name.
4. Optionally filter the resources based on the provided project_id.
5. Format the retrieved resource data.
6. Construct the response body containing the formatted resource data.
7. Return a 200 OK response with the formatted data.
8. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
9. Finally, close the database connection. 

#### 4.getResourcesByRole

##### API Description:
The getResourcesByRole API retrieves resources based on their designation or role.

##### Endpoint:
- Method: GET
- Path: /get_resource_by_role

##### Request Parameters:
- designation: string (optional) - The designation or role of the resources to retrieve.

##### Response:
- Success Response (HTTP 200):
  - Body: JSON array containing resource details matching the provided designation.
- Error Response (HTTP 400/500):
  - Body: { "message": "Resource role is missing" } (HTTP 400) or { "message": "Internal Server Error"} (HTTP 500)

##### Pseudocode for getResourcesByRole API:
1. Parse the designation query parameter from the request.
2. Validate the designation parameter as a string.
3. If the validation fails, return a 400 Bad Request response.
4. Connect to the database.
5. Execute a query to retrieve resources based on the provided designation.
6. Format the retrieved resource data.
7. Construct the response body containing the formatted resource data.
8. Return a 200 OK response with the formatted data.
9. If any error occurs during the process:
    - Catch the error, log it, and return a 500 Internal Server Error response.
10. Finally, close the database connection.