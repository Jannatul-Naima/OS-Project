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
    echo "$name: $description" >> "$TASK_FILE"
    echo "Task added successfully."
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

