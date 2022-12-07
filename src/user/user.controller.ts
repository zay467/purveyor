import { Body, Controller, Post } from '@nestjs/common';
import { UserDto } from './dto';
import { UserService } from './user.service';

@Controller('user')
export class UserController {
  constructor(private userService: UserService) {}

  @Post()
  create_user(@Body() userDto: UserDto) {
    return this.userService.create_user(userDto);
  }
}
