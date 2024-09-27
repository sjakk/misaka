#include "game.h"
#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_surface.h>
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

//excluir depois
SDL_Surface* pTempSurface = SDL_LoadBMP("assets/rider.bmp");
m_pTexture = SDL_CreateTextureFromSurface(m_pRenderer,pTempSurface);

SDL_FreeSurface(pTempSurface);

SDL_QueryTexture(m_pTexture,NULL,NULL, &m_sourceRectangle.w,&m_sourceRectangle.h);

m_sourceRectangle.w = 50;
m_sourceRectangle.h = 50;
m_destinationRectangle.x = m_sourceRectangle.x = 0;
m_destinationRectangle.y = m_sourceRectangle.y = 0;

m_destinationRectangle.x = 100;
m_destinationRectangle.y = 100;

m_sourceRectangle.x = 50;
m_sourceRectangle.y = 50;

m_destinationRectangle.w = m_sourceRectangle.w;
m_destinationRectangle.h = m_sourceRectangle.h;

//ex





return true;
}


void Game::render(){
	SDL_RenderClear(m_pRenderer);
	SDL_RenderCopy(m_pRenderer,m_pTexture,NULL,NULL);
	SDL_RenderPresent(m_pRenderer);
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


