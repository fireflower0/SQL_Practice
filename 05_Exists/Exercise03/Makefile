TARGET   = exercise03
SRC      = $(TARGET).sql
COMPILER = psql
USER     = fireflower0
HOST     = localhost
DB       = test

run:
	$(COMPILER) -U $(USER) -h $(HOST) -d $(DB) -a -f $(SRC)
