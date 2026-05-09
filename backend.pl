
%Name: Eshitasri Punuganti
%Date: 04/29/2026 - 05/08/2026
%Purpose: create a prolog backend that will allow a user to prepare a work schedule based on the facts given

%code for project 2

% FAIL definitions

workstation_idle(_,_) :- FAIL.
avoid_workstation(_,_) :- FAIL.
avoid_shift(_,_) :- FAIL.

% ------------------------------------------------------------------------------------------------------------------------

% main predicate PLAN
plan(plan(Morning, Evening, Night)) :-

    %make a list of all the employees
    findall(E, employee(E), employees),

    %build the morning shift
    assign_shift(morning, Employees, Morning, RemainingMorning),

    %build the evening shift
    assign_shift(evening, RemainingMorning, Evening, RemainingEvening),

    %build the night shift
    assign_shift(night, RemainingEvening, Night, RemainingNight),

    %every employee must be assigned once (so there should be an empty list leftover)
    ReaminingNight = [].

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

    % pick the subset of the employees that need to be assigned (subset function)
    subset(AssignedEmployees, AvailableEmployees),

    % check the size constraints to make sure its within the bounds of min and max
    length(AssignedEmployees, Count),
    
    Count >= Min,
    Count =< Max,

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
subset([], []).

% keep the element
subset([X | Tail], [X | Rest]) :-
    subset(Tail, Rest).

% remove the element
subset(Tail, [_ | Rest]) :-
    subset(Tail, Rest).

% ------------------------------------------------------------------------------------------------------------------------

% subtract function
% remove all the elements of List2 from List1

% base case: two empty lists
subtract([], _, []).

% Remove element from the list and return the resulting list
subtract([H | T], Remove, Result) :-
    member(H, Remove),
    !,
    subtract(T, Remove, Result).

% if the element is not in the list, keep it
subtract([H | T], Remove, [H | Result]) :-
    subtract(T, Remove, Result).

% member function
% check if the element is part of the list

member(X, [X | _]).
member(X, [_, T]) :- 
    member(X, T).
