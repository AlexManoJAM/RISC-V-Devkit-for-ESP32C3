#include <mdk.h>
#include <soma.h>
#include <div.h>
int main(void) {
  wdt_disable();
  gpio_output(LED1);
  gpio_input(BTN1);
  soma();
  divisao();
  bool previous = gpio_read(BTN1);

  for (;;) {
    bool current = gpio_read(BTN1);
    if (current != previous) {
      gpio_write(LED1, !previous);
      printf("BTN: %d -> %d\n", previous, current);
      previous = current;
    }
    delay_ms(10);
  }

  return 0;
}
