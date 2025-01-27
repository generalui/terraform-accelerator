import os
import sys
from logging import Logger
import logging
from loguru import logger

LOG_PREFIX = 'Example-Python-Batch-ECR'

# Load environment variables
aws_region = os.getenv('REGION', 'us-east-2')
test_value = os.getenv('TEST', 'test')
in_vpc = os.getenv('IN_VPC', False)

log_format = (
    "<fg 150,150,150>{time:MM-DD-YYYY HH:mm:ss:SSS}</fg 150,150,150> - "  # datetime
    "<fg 150,150,150>{name}:{line}</fg 150,150,150> - "  # filename and line of code associated with the log
    "<level>[{level}]</level> "  # log level
    "{message}"
)


class InterceptHandler(logging.Handler):
    """
    Intercept other loggers messages
    """
    loglevel_mapping = {
        50: "CRITICAL",
        40: "ERROR",
        30: "WARNING",
        20: "INFO",
        10: "DEBUG",
        0: "NOTSET",
    }

    def emit(self, record):
        """
        redifinition of parent method, do whatever it takes to actually log the specified logging record.
        :param record: message received by intercepted logger
        """
        try:
            level = logger.level(record.levelname).name
        except AttributeError:
            level = self.loglevel_mapping[record.levelno]

        frame, depth = logging.currentframe(), 2
        while frame.f_code.co_filename == logging.__file__:
            frame = frame.f_back
            depth += 1

        log = logger.bind(request_id="app")
        log.opt(depth=depth, exception=record.exc_info).log(level, record.getMessage())


def get_logger(level: str = "INFO", intercept: list[str] = None) -> Logger:
    """
    create and returns an eo standard logger
    :param level: logging level, must be one [DEBUG | INFO | WARNING | ERROR]
    :param intercept: list of logger names to intercept, messages from these loggers will be redirected to this one.
    :return: configured loguru logger
    """
    logger.remove()
    logger.add(sys.stdout, enqueue=True, backtrace=True, level=level.upper(), format=log_format, serialize=True)

    logging.basicConfig(handlers=[InterceptHandler()], level=0)
    logging.getLogger("uvicorn.access").handlers = [InterceptHandler()]
    if intercept:
        for _log in intercept:
            _logger = logging.getLogger(_log)
            _logger.handlers = [InterceptHandler()]
            _logger.disabled = True

    logger.bind(request_id=None, method=None)
    logger.level("INFO", color="<green>")

    return logger



def test_worker():
    logger.info(f'{LOG_PREFIX}: Testing the batch worker. aws_region = {aws_region}, in_vpc = {in_vpc}')

logger.info(f'{LOG_PREFIX}: Hello World!')
# Test the batch worker
test_worker()
logger.info(f'{LOG_PREFIX}: All done')

# Uncomment to test Failure
# raise Exception('Something went wrong')
