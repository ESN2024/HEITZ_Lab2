#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"
#include "system.h"
#include "sys/alt_irq.h"
#include "io.h"
#include "unistd.h"
#include "sys/time.h"
#include "sys/alt_sys_init.h"

#include <stdio.h>



volatile alt_u16 compteur=0;


// fonction effectu� lors de lorque le timer g�n�re une interuption.
static void Timer_handler(void* context, alt_u32 id)
{
	compteur=compteur+1; // incr�mentation du cpt
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0);// remise � l'�tat initial du flag
}


int main() {

	// Initialisation timer (flag,p�riode, mask)
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE, ALTERA_AVALON_TIMER_CONTROL_CONT_MSK | ALTERA_AVALON_TIMER_CONTROL_START_MSK | ALTERA_AVALON_TIMER_CONTROL_ITO_MSK);
	alt_irq_register(TIMER_0_IRQ, NULL, (void*)Timer_handler);

	while(1)
	{
		IOWR_ALTERA_AVALON_PIO_DATA(SEGDECOD_BUS_BASE, compteur); //affichage sur les d�codeurs 7 seg

		if(compteur==999)compteur=0;// remise � Z�ro du compteur pour �viter le d�passement.
	}
	return 0;
}
