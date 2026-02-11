# Agent Rules

- always write a SOW and then ask user a permission before editing any code.
- Keep the summarize of the change under ./change_logs once the editing is fully done. make sure that the change log file name starts with YYYY-MM-DD to keep them organize them.
- Add google style docstring and typehints to all functions and classes
- Alway apply the formatter command to the files that are changed or newly added. `formatter <path_to_the_changed_files>`.
- Please run and debug the code before submitting the code to the user. If the code is Python, Please check the appropriate python environment packages `uv` (or `conda`) in the closest parent directory and use them to run the code.
- Always ask user a permission before deleting any files or folders.
