#pragma once

#include <string>

class IShell {
public:
    IShell(const std::string &appName);

    void start();

private:
    std::string getInput();
    void processCommand(const std::string &line);
    void print_help();

    std::string prompt;
};