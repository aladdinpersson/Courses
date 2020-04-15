import re
from collections import defaultdict

def part1(graph, degree_incoming):
    curr_accessible_nodes = []
    for node in graph:
        if degree_incoming[node] == 0: curr_accessible_nodes.append(node)

    path = []
    while curr_accessible_nodes:
        min_node = sorted(curr_accessible_nodes)[0]
        path.append(min_node)
        curr_accessible_nodes.remove(min_node)

        for connected_node in graph[min_node]:
            degree_incoming[connected_node] -= 1

            # If it now has 0 incoming degrees, add it to our list
            # which will take the alphabetically sorted one
            if degree_incoming[connected_node] == 0:
                curr_accessible_nodes.append(connected_node)

    return ''.join(path)

def get_workers(workers, total_time):
    flag_zero = False
    indices = []

    while not flag_zero:
        minimum = min(worker for worker in workers if worker > 0)
        total_time += minimum

        for i in range(len(workers)):
            if workers[i] is not 0:
                workers[i] = max(workers[i] - minimum, 0)
                if workers[i] == 0:
                    flag_zero = True
                    indices.append(i)


    return workers, indices, total_time

def part2(graph, degree_incoming, num_workers):
    path=[]
    workers = [0 for i in range(num_workers)]
    working_nodes = [None for i in range(num_workers)]

    curr_accessible_nodes = []

    for node in graph:
        if degree_incoming[node] == 0: curr_accessible_nodes.append(node)

    total_time = 0

    while curr_accessible_nodes or sum(workers) > 0:
        free_workers = workers.count(0)

        for i in range(min(free_workers, len(curr_accessible_nodes))):
            min_node = sorted(curr_accessible_nodes)[0]
            curr_accessible_nodes.remove(min_node)
            workers[i] = 1 + ord(min_node) - ord('A')
            working_nodes[i] = min_node

        workers, indices, total_time = get_workers(workers, total_time)
        print(workers)
        print(indices)
        print(working_nodes)
        print()

        for idx in indices:
            min_node = working_nodes[idx]
            # print(min_node)
            path.append(min_node)
            working_nodes[idx] = None
            # print(degree_incoming)

            for connected_node in graph[min_node]:
                # if connected_node == 'G':
                #     print("hi")
                # print(degree_incoming)
                degree_incoming[connected_node] -= 1

                # If it now has 0 incoming degrees, add it to our list
                # which will take the alphabetically sorted one
                # if connected_node == 'G':
                #     print(degree_incoming[connected_node])

                if degree_incoming[connected_node] == 0:
                    curr_accessible_nodes.append(connected_node)
                    # print(connected_node)

    print(path)
    return total_time


def main():
    graph = defaultdict(list)
    degree_incoming = defaultdict(int)

    for line in open('input.txt'):
        from_node, to_node = [char.replace(' ', '') for char in re.findall(r' . ', line)]
        graph[from_node].append(to_node)
        degree_incoming[to_node] += 1

    # part1_ans = part1(graph, degree_incoming)
    # print(f'Answer to part 1 is {part1_ans}')

    num_workers = 2
    part2_ans = part2(graph, degree_incoming, num_workers)
    print(f'Answer to part 2 is {part2_ans}')

if __name__ == '__main__':
    main()