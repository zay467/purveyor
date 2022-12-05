import { Module } from '@nestjs/common';
import { MatchService } from './match.service';
import { MatchController } from './match.controller';
import { TicketTypeService } from './ticket_type/ticket_type.service';
import { TicketService } from './ticket/ticket.service';

@Module({
  providers: [MatchService, TicketTypeService, TicketService],
  controllers: [MatchController],
})
export class MatchModule {}
