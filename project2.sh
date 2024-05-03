#!/bin/bash

# Define the filename for the task list
TASK_FILE="tasks.txt"

# Function to display the menu
display_menu() {
    echo 
    echo "Task Management System"
    echo "----------------------"
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Remove Task"
    echo "4. Rename Task"
    echo "5. Search Task"
    echo "6. Exit"
    echo
}

# Function to add a task
add_task() {
    echo "Enter task name:"
    read name
    echo "Enter task description:"
    read description
    echo "Enter due date (YYYY-MM-DD):"
    read due_date
    echo "$name: $description (Due: $due_date)" >> "$TASK_FILE"
    echo "Task added successfully."

    # Notify about due tasks
    check_due_tasks "$due_date"
}

# Function to view tasks
view_tasks() {
    if [ -s "$TASK_FILE" ]; then
        echo "Tasks:"
        cat "$TASK_FILE"
    else
        echo
        echo "No tasks found."
    fi
}

# Function to remove a task
remove_task() {
    echo "Enter task number to remove:"
    read task_number
    sed -i "${task_number}d" "$TASK_FILE"
    echo
    echo "Task removed successfully."
}

# Function to rename a task
rename_task() {
    echo "Enter task number to rename:"
    read task_number
    echo "Enter new task description:"
    read new_description
    sed -i "${task_number}s/.*/$new_description/" "$TASK_FILE"
    echo
    echo "Task renamed successfully."
}

# Function to search for a task
search_task() {
    echo "Enter keyword to search for:"
    read keyword
    if grep -qi "$keyword" "$TASK_FILE"; then
        grep -i "$keyword" "$TASK_FILE"
    else
        echo
        echo "No tasks found matching the keyword \"$keyword\"."
    fi
}

# Function to check for due tasks
check_due_tasks() {
    due_date="$1"
    current_date=$(date +%Y-%m-%d)

    if [ "$due_date" \< "$current_date" ]; then
        echo "This task is overdue!"
    elif [ "$due_date" = "$current_date" ]; then
        echo "This task is due today!"
    else
        days_left=$(( ($(date -d "$due_date" +%s) - $(date -d "$current_date" +%s)) / 86400 ))
        echo "This task is due in $days_left days."
    fi
}

# Main function
main() {
    while true; do
        display_menu
        echo "Enter your choice:"
        read choice

        case $choice in
            1)
                add_task
                ;;
            2)
                view_tasks
                ;;
            3)
                remove_task
                ;;
            4)
                rename_task
                ;;
            5)
                search_task
                ;;
            6)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter a number from 1 to 6."
                ;;
        esac
    done
}

# Run the main function
main

