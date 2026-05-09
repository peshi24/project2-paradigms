
%Name: Eshitasri Punuganti
%Date: 04/29/2026 - 05/08/2026
%Purpose: create a prolog backend that will allow a user to prepare a work schedule based on the facts given

%code for project 2

%import library lists functions for the subtract and member functions
:- use_module(library(lists)).

%consult the testing.pl
%:- consult('testing.pl').

%trace --> for testing

% FAIL definitions

:- dynamic workstation_idle/2.
:- dynamic avoid_workstation/2.
:- dynamic avoid_shift/2.

% ------------------------------------------------------------------------------------------------------------------------

% main predicate PLAN
plan(plan(Morning, Evening, Night)) :-

    %make a list of all the employees
    findall(E, employee(E), Employees),

    %build the morning shift
    assign_shift(morning, Employees, Morning, RemainingMorning),

    %build the evening shift
    assign_shift(evening, RemainingMorning, Evening, RemainingEvening),

    %build the night shift
    assign_shift(night, RemainingEvening, Night, RemainingNight),

    %every employee must be assigned once (so there should be an empty list leftover)
    RemainingNight = [].

% ------------------------------------------------------------------------------------------------------------------------

% assign_shift function -> creates schedule for each shift
% parameters: shift, employees that have been assigned, employees that haven't been assigned, and the shift list

assign_shift(Shift, AvailableEmployees, ShiftList, RemainingEmployees) :-

    % get all the workstations from the facts doc that ARE NOT IDLE
    % \+ is a negation as failure operator

    findall(W, 
        (
            workstation(W, _, _),
            \+ workstation_idle(W, Shift)
        ),
        ActiveWorkstations),

    % build the schedule for the workstations

    assign_workstations(ActiveWorkstations, Shift, AvailableEmployees, ShiftList, RemainingEmployees).

% ------------------------------------------------------------------------------------------------------------------------

% base case
% no workstations left to assign (empty list)

assign_workstations([], _, Employees, [], Employees).


% recursive case
% pull each element [ element | list ]

assign_workstations(
            [W | RestWorkstations],
            Shift,
            AvailableEmployees,
            [workstation(W, AssignedEmployees) | RestPlan],
            RemainingEmployees
        ) :-

    % get the workstation limits from the facts doc (same format)
    workstation(W, Min, Max),

    % choose the valid employees, so available employees
    choose_workers(W, Shift, AvailableEmployees, Min, Max, AssignedEmployees),

    % remove the assigned employees through the subtract function
    subtract(AvailableEmployees, AssignedEmployees, NewAvailableEmployees),

    % continue the recursion with remaining elements
    assign_workstations(RestWorkstations, Shift, NewAvailableEmployees, RestPlan, RemainingEmployees).

% ------------------------------------------------------------------------------------------------------------------------

% choose workers function to select a valid employee group for the workstation
choose_workers(W, Shift, AvailableEmployees, Min, Max, AssignedEmployees) :-

    % set the count value
    between(Min, Max, Count),

    % check the size constraints to make sure its within the bounds of min and max
    length(AssignedEmployees, Count),

    % pick the subset of the employees that need to be assigned (subset function)
    generate_subset(AssignedEmployees, AvailableEmployees),

    % validate all the employees to make sure it still works with all the constraints (the avoidances)
    validate(AssignedEmployees, W, Shift).

% ------------------------------------------------------------------------------------------------------------------------

% validate function to make sure the employee assignment fits the workstation and shift requirements

validate([], _, _).

validate([E | Rest], W, Shift) :-

    % check if the employee NEEDS to avoid the workstation
    \+ avoid_workstation(E, W),

    % check if the employee NEEDS to avoid the shift
    \+ avoid_shift(E, Shift),

    % loop back to check the rest
    validate(Rest, W, Shift).

% ------------------------------------------------------------------------------------------------------------------------

% subset function 

% base case: empty list
generate_subset([], _).

% keep the element
generate_subset([X | Tail], [X | Rest]) :-
    generate_subset(Tail, Rest).
generate_subset(Sub, [_ | Rest]) :-
    generate_subset(Sub, Rest).

% -------------------------------------------------------------------------------------------------------------------------

% testing functions

% test to see if employee is at a given workstation during a shift
% morning
works_at(plan(Morning, _, _), morning, E, W) :-
    member(workstation(W, Employees), Morning),
    member(E, Employees).

% evening
works_at(plan(_, Evening, _), evening, E, W) :-
    member(workstation(W, Employees), Evening),
    member(E, Employees).

% night
works_at(plan(_, _, Night), night, E, W) :-
    member(workstation(W, Employees), Night),
    member(E, Employees).

% test to see if an employee appears in zero shifts
% not a necessary function because RemainingNight takes care of this
no_work(Plan, E) :-
    employee(E),
    \+ works_at(Plan, morning, E, _),
    \+ works_at(Plan, evening, E, _),
    \+ works_at(Plan, night, E, _).

% test to see if an employee appears in more that one shift
double_work(Plan, E) :-
    employee(E),
    works_at(Plan, Shift1, E, _),
    works_at(Plan, Shift2, E, _),
    Shift1 \= Shift2.