#include "version.h"

#include <iostream>

int
main()
{
    auto sha     = git_sha();
    auto version = deploy_version();

    std::cout << "GIT: " << sha << " DEPLOY: " << version << std::endl;

    return 0;
}
