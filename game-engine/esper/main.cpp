#include "game.h"


Game* g_pGame = nullptr;



int main(){

g_pGame = new Game();

g_pGame->init("esper",100,100,640,480,0);

while(g_pGame->running()){
g_pGame->handleEvents();
g_pGame->update();
g_pGame->render();
}
g_pGame->clean();


return 0;
}
