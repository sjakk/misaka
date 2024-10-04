#include "game.h"
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_surface.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_video.h>
#include <iostream>



bool Game::init(const char* title, int xpos, int ypos, int width, int
height, bool fullscreen){
int flags = 0;

if(fullscreen){
	flags = SDL_WINDOW_FULLSCREEN;
}

if(SDL_Init(SDL_INIT_EVERYTHING) == 0){
	std::cout << "SDL init success\n";
	this->m_pWindow = SDL_CreateWindow(title,xpos, ypos, width, height, flags);

	if(m_pWindow != nullptr){
		std::cout << "Window Created Successfully\n";
		this->m_pRenderer = SDL_CreateRenderer(m_pWindow, -1,0);

		if(m_pRenderer != nullptr){
			std::cout << "Rederer Created Successfully\n";
			SDL_SetRenderDrawColor(m_pRenderer, 0, 0,0,255);
		}else{
			std::cout << "Render Init Failed\n";
			return false;
		}
	}else{
		std::cout << "Window Init Fail\n";
		return false;
	}
}else{
	std::cout << "SDL init fail\n";
	return false;
}

std::cout << "All Initialized Successfully\n";
m_bRunning = true;

m_textureManager.load("assets/animate-alpha.png","animate",m_pRenderer);

SDL_SetRenderDrawColor(m_pRenderer, 255, 0, 0, 255);
SDL_QueryTexture(m_pTexture,NULL,NULL, &m_sourceRectangle.w,&m_sourceRectangle.h);




return true;
}


void Game::render(){
	SDL_RenderClear(m_pRenderer);
	SDL_RenderCopyEx(m_pRenderer,m_pTexture,&m_sourceRectangle,&m_destinationRectangle,0,0,SDL_FLIP_HORIZONTAL);

        m_textureManager.draw("animate",50,50,128,82,m_pRenderer);
        m_textureManager.drawFrame("animate", 100, 100, 128, 82, 1,m_currentFrame,m_pRenderer);

	SDL_RenderPresent(m_pRenderer);
}

void Game::update(){
	//m_sourceRectangle.x = 128 * int((SDL_GetTicks() / 100) % 6);
	m_currentFrame = int((SDL_GetTicks() / 100)%6);
}


void Game::clean(){
	std::cout << "Cleaning Game\n";
	SDL_DestroyWindow(m_pWindow);
	SDL_DestroyRenderer(m_pRenderer);
	SDL_Quit();
}



void Game::handleEvents(){
	SDL_Event event;
	if(SDL_PollEvent(&event)){
		switch(event.type){
			case SDL_QUIT:
				m_bRunning = false;
				break;

			default:
				break;
		}

	}
}


