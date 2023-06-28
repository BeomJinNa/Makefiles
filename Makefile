#parameters====================================================================

CC		= cc
AR		= ar
ARFLAGS	= crs
CFLAGS	= -Wall -Wextra -Werror

NAME	= #program name
INCLUDE	= includes/



#libraries=====================================================================

LIBS	= libft
B_LIBS	= libft_bonus
ARCH	= ft
B_ARCH	= ft_bonus

LIBFT	= libft/libft.a
LIBFT_B	= libft_bonus/libft_bonus.a



#sources=======================================================================

SRCS	= #source files(*.c)

B_SRCS	= #bonus source files(*.c)

OBJS	= $(SRCS:.c=.o)
B_OBJS	= $(B_SRCS:.c=.o)




ifdef BONUS
	TARGET_OBJS = $(B_OBJS)
	TARGET_LIB = $(LIBFT_B)
	TARGET_LIBS = $(B_LIBS)
	TARGET_ARCH = $(B_ARCH)
else
	TARGET_OBJS = $(OBJS)
	TARGET_LIB = $(LIBFT)
	TARGET_LIBS = $(LIBS)
	TARGET_ARCH = $(ARCH)
endif

#rules=========================================================================

.PHONY: all
all :
	make $(NAME)

$(NAME) : $(TARGET_LIB) $(TARGET_OBJS)
	$(CC) -o $@ $(TARGET_OBJS) $(foreach lib, $(TARGET_LIBS), -L$(lib)) $(foreach arch, $(TARGET_ARCH), -l$(arch))


$(LIBFT) :
	make -C libft

$(LIBFT_B) :
	make -C libft_bonus



.PHONY: bonus
bonus :
	make BONUS=0 $(NAME)

#const options=================================================================

%.o : %.c
	$(CC) $(CFLAGS) -I$(INCLUDE) -c $< -o $@

.PHONY: clean
clean :
	$(foreach lib, $(LIBS), make fclean -C $(lib);)
	$(foreach lib, $(B_LIBS), make fclean -C $(lib);)
	rm -f $(OBJS) $(B_OBJS)

.PHONY: fclean
fclean :
	make clean
	rm -f $(NAME)

.PHONY: re
re :
	make fclean
	make all
