# -*- coding: utf-8 -*-

'''
Purpose of this code is to check if graph is connected between two nodes using breadth first search

Programmed by Aladdin Persson <aladdin.persson@umu.se>
*   2019-02-22 Initial programming
*   2019-03-15 Modified code to be able to handle arbitrary string inputs, as previous was assuming integers in input.
'''

import argparse
import sys
from collections import deque


class Graph_connectivity(object):
    def __init__(self):
        pass

    def prepare_args(self, args):
        parser = argparse.ArgumentParser(description = "Check connectivity between two nodes using BFS")
        parser.add_argument('graph_file', default = None, type=str, help='Textfile name to graph (default: none)')
        args = parser.parse_args(args)
        return args

    def load_graph(self, file):
        try:
            f = open(file, 'r')
        except IOError:
            raise IOError("File doesn't exist!")

        line_list = f.readlines()

        graph = {}

        for line in line_list[1:]:
            from_node, to_node = line.split()
            graph.setdefault(from_node, []).append(to_node)
            graph.setdefault(to_node, [])

        f.close()

        return graph

    def bfs(self, graph, start_node):
        visited = {node: False for node in graph}

        queue = deque()
        queue.append(start_node)
        path = []

        while queue:
            # the leftmost element is the first one added to the queue
            curr_node = queue.popleft()
            path.append(curr_node)

            if not visited[curr_node]:
                visited[curr_node] = True

                for connected_node in graph[curr_node]:
                    if not visited[connected_node]:
                        queue.append(connected_node)

        return visited, path

    def main(self):
        # using argparse is overkill, but good practice as it is more convenient with larger programs
        args = self.prepare_args(sys.argv[1:])
        graph = self.load_graph(args.graph_file)

        user_input = input("Enter origin and destination (quit to exit): ")

        while user_input.lower() != 'quit':
            from_node, to_node = user_input.split()

            # Path not necessary for this program
            visited, path = self.bfs(graph, from_node)

            if visited[from_node] and visited[to_node]:
                print(f'{from_node} and {to_node} are connected')
            else:
                print(f'{from_node} and {to_node} are not connected')

            user_input = input("Enter origin and destination (quit to exit): ")

if __name__ == '__main__':
    Graph_connectivity().main()