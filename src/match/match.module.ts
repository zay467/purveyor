import { Module } from '@nestjs/common';
import { MatchService } from './match.service';
import { MatchController } from './match.controller';
import { MatchTypeService } from './match_type/match_type.service';

@Module({
  providers: [MatchService, MatchTypeService],
  controllers: [MatchController],
})
export class MatchModule {}
